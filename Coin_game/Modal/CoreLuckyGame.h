//
//  CoreLuckyGame.h
//  LuckyPad
//
//  Created by Nguyen Van Dung on 3/5/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RewardInfo.h"

@interface CoreLuckyGame : NSObject
{
    
}


+ (CoreLuckyGame *) shareInstance;
- (RewardInfo *) calculateReward :(NSMutableArray *)listRewards;

@end
