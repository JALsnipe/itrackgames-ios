//
//  TGViewControllerGameList.m
//  iTrackGames
//
//  Created by Toni White on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameTableViewController.h"
#import <RestKit/RestKit.h>
#import "TGGame.h"
#import "TGGameViewController.h"
#import "TGGameStashDatumMediator.h"

static NSString *reuseIdentifier = @"TGGameCell";

@interface TGGameTableViewController ()

@property (nonatomic, strong) TGGamesDataSource *dataSource;
@property (nonatomic, strong) TGGameStashDatumMediator *gameStashDatumMediator;

@end

@implementation TGGameTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.gameStashDatumMediator = [[TGGameStashDatumMediator alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor magentaColor]];
    
    UINib *nib = [UINib nibWithNibName:@"TGGameTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = 80.0f;
    
    self.dataSource = [[TGGamesDataSource alloc] initWithPlatform:self.platform];
    self.dataSource.delegate = self;
    
    [self.dataSource reloadDataIfNeeded];
}

#pragma mark - TGGameTableViewCellDelegate

- (void)gameTableViewCell:(TGGameTableViewCell *)cell didTapRatingStar:(NSInteger)starIndex
{
    [cell hideRatingsView];
    
    TGGame *game = [self.games objectAtIndex:[self.tableView indexPathForCell:cell].row];
    
    [self.gameStashDatumMediator updateGame:game withPlayStatus:YES rating:starIndex];
    
    [self.tableView reloadData];
}

#pragma mark - actions

- (IBAction)checkBoxButtonTapped:(id)sender
{
    UIButton *checkButton = (UIButton *)sender;
    
    TGGameTableViewCell * cell = (TGGameTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:checkButton.tag inSection:0]];
    cell.delegate = self;
    
    [cell displayRatingsView];
}

#pragma mark - Table view data source

- (NSArray *) games {
    
    return [self.dataSource games];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.games.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TGGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    TGGame *game = [self.games objectAtIndex:indexPath.row];
    [cell setGame:game];
    
    cell.checkboxButton.tag = indexPath.row;
    [cell.checkboxButton addTarget:self action:@selector(checkBoxButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TGGameViewController *viewController = [[TGGameViewController alloc] initWithNibName:@"TGGameViewController" bundle:nil];
    
    viewController.gameId = [(TGGame *)[self.games objectAtIndex:indexPath.row] game_id];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TGViewDataSourceDelegate

-(void)viewDataSourceDidUpdateContent:(id<TGViewDataSource>)dataSource
{
    [self.tableView reloadData];
}

-(void)viewDataSource:(id<TGViewDataSource>)dataSource didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

-(void)dealloc
{
    
}

@end
