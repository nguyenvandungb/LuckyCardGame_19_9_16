//
//  Reward.m
//  LuckyPadSony
//
//  Created by dungnv9 on 1/25/15.
//  Copyright (c) 2015 Applekikaku. All rights reserved.
//

#import "Reward.h"


@implementation Reward

@dynamic isEnable;
@dynamic name;
@dynamic rwID;
@dynamic played;
@dynamic remain;
@dynamic total;
- (void) fillDataFrom:(RewardInfo *)info
{
    if (info){
        self.isEnable = [NSNumber numberWithBool:info.isEnable];
        self.name = info.name;
        self.rwID = [NSNumber numberWithInt:(int) info.rwID ];
        self.total = [NSNumber numberWithInt:(int) info.total ];
        self.remain = [NSNumber numberWithInt:(int) info.remain ];
        self.played = [NSNumber numberWithInt:(int) info.played ];
        
    }
}
@end
