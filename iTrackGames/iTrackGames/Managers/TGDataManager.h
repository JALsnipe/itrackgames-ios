//
//  TGDataManager.h
//  iTrackGames
//
//  Created by Toni White on 3/3/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGPlatform.h"
#import "TGGame.h"

typedef void(^TGDataManagerCompletionBlockType)(id data, NSError *error);

@interface TGDataManager : NSObject

-(void) fetchUserTokenWithUsername: (NSString *) username andPassword: (NSString *) password withCompletion:(TGDataManagerCompletionBlockType) completionBlock;
- (void)fetchPlatformsWithCompletion:(TGDataManagerCompletionBlockType)completionBlock;
-(void) fetchGamesWithPlatform: (TGPlatform *) platform withCompletion: (TGDataManagerCompletionBlockType)completionBlock;
-(void) fetchGameData: (NSNumber *)gameId withCompletion: (TGDataManagerCompletionBlockType) completionBlock;

@end
