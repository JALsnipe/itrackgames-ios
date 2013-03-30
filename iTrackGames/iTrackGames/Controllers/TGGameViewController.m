//
//  TGGameViewController.m
//  iTrackGames
//
//  Created by Toni White on 2/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameViewController.h"
#import <RestKit/RestKit.h>

@interface TGGameViewController ()

@end

@implementation TGGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect collectionViewFrame = CGRectMake(0.0f, CGRectGetMaxY(self.overviewTextView.frame) + 10, self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.overviewTextView.frame) - 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView setBackgroundColor:[UIColor blueColor]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    
    [self fetchData];
}

-(void) fetchData
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSString *path = [NSString stringWithFormat:@"/games/%i.json",[self.game.game_id intValue]];
    
    [objectManager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        self.game = [mappingResult firstObject];
        [self populateText];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed in fetchData.");
    }];
}

-(void) populateText
{
    self.titleLabel.text = self.game.title;
    self.developerLabel.text = self.game.developer;
    self.publisherLabel.text = self.game.publisher;
    self.overviewTextView.text = self.game.overview;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Data Source 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    MACachedImageView *imageView = [[MACachedImageView alloc] initWithFrame:cell.contentView.bounds];
    imageView.clipsToBounds = YES;
    [imageView displayImageFromURL:[NSURL URLWithString:@"http://thegamesdb.net/banners/screenshots/thumb/2-1.jpg"]];
    
    [cell.contentView addSubview:imageView];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, collectionView.bounds.size.height);
}

@end
