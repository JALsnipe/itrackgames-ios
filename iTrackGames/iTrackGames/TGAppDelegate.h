//
//  TGAppDelegate.h
//  iTrackGames
//
//  Created by Amanda Chappell on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGViewController;

@interface TGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TGViewController *viewController;

@end