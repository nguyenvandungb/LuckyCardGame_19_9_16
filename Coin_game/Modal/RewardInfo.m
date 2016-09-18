//
//  RewardInfo.m
//  roulette
//
//  Created by FSIOSTeam on 11/3/12.
//  Copyright (c) 2012 FSIOSTeam. All rights reserved.
//

#import "RewardInfo.h"
#import "Reward.h"

@implementation RewardInfo

@synthesize  rwID;
@synthesize  played;
@synthesize  remain;
@synthesize  total;
@synthesize numberOfCurrentPlayed = _numberOfCurrentPlayed;
@synthesize name = _name;
@synthesize isEnable;
- (void) saveToCoreData
{
    Reward* __mo = [Reward MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"rwID=%d",self.rwID] inContext:[NSManagedObjectContext MR_defaultContext]];
    if (!__mo) {
        __mo = [Reward MR_createInContext:[NSManagedObjectContext MR_defaultContext]];
    }
    [__mo fillDataFrom:self];
    
    
}
- (id) initWithCoreData:(Reward *)info
{
    if (!info){
        return nil;
    }
    self = [super init];
    if (self){
        self.rwID = [info.rwID intValue];
        self.played = [info.played intValue];
        self.total = [info.total intValue];
        self.remain  = [info.remain intValue];
        self.name = info.name;
        self.isEnable = [info.isEnable boolValue];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    RewardInfo *info = [[RewardInfo alloc] init];
    info.rwID = self.rwID;
    info.isTimingObj = self.isTimingObj;
    info.played = self.played;
    info.remain = self.remain;
    info.total = self.total;
    info.numberOfCurrentPlayed = self.numberOfCurrentPlayed;
    info.name = self.name;
    info.isEnable = self.isEnable;
    return info;
}
- (void) deselect
{
    self.isChecked = NO;
}
- (id) init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}


- (void) showLog
{
   // NSLog(@"\n0x%8@ ->ID: %d - played: %d - remain :%d  total :%d",self,self.rwID,self.played,self.remain,self.total);
}
@end
