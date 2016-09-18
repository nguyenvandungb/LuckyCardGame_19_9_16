//
//  Time.m
//  LuckyPadSony
//
//  Created by dungnv9 on 1/25/15.
//  Copyright (c) 2015 Applekikaku. All rights reserved.
//

#import "Time.h"


@implementation Time
@dynamic timeInterval;
@dynamic unikey;
@dynamic index;
@dynamic dateSetup;
@dynamic timeSetup;
@dynamic timeWin;
@dynamic dateWin;
@dynamic rewardID;
@dynamic isOut;
@dynamic isSelected;
- (void) fillDataFrom:(TimeObject *)info
{
    if (info){
        self.timeInterval = [NSNumber numberWithDouble:info.timeInterval];
        self.unikey = info.unikey;
        self.index  = [NSNumber numberWithInt:info.index];
        self.dateSetup = info.dateSetup;
        self.timeSetup = info.timeSetup;
        self.timeWin = info.timeWin;
        self.dateWin= info.dateWin;
        self.rewardID = [NSNumber numberWithInt:info.rewardID];
        self.isOut = [NSNumber numberWithBool:info.isOut];
        self.isSelected = [NSNumber numberWithBool:info.isSelected];
    }
}
@end
