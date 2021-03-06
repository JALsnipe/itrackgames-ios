//
//  TGSplitViewController.h
//  iTrackGames
//
//  Created by Amanda Chappell on 7/20/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGSplitViewController : UIViewController

@property (nonatomic) CGPoint splitPoint;
@property (nonatomic, strong) UIView *splitView;
@property (nonatomic, strong) UIViewController *detailViewController;

- (void)animateViewSplit;

@end
