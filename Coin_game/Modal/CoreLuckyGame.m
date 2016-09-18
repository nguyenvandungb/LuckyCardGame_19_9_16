//
//  CoreLuckyGame.m
//  LuckyPad
//
//  Created by Nguyen Van Dung on 3/5/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import "CoreLuckyGame.h"
#import "RewardInfo.h"
#define MIN___ @"min"
#define  MAX___ @"max"



static CoreLuckyGame                *_this = nil;

@implementation CoreLuckyGame

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
    
    _this = self;
    return _this;
}


+ (CoreLuckyGame *) shareInstance
{
    if (!_this)
    {
        _this = [[CoreLuckyGame alloc] init];
    }
    return _this;
}


- (RewardInfo *) calculateReward :(NSMutableArray *)listRewards
{
    RewardInfo *lastInfo = [listRewards lastObject];
    long long totalRemain = 0;
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    for (NSInteger i = listRewards.count -1; i >=0; i--)
    {
        RewardInfo *info = [listRewards objectAtIndex:i];
        if (info.remain >0)
        {
            totalRemain += info.remain;
            NSDictionary *dict = nil;
            dict  = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:(int)(totalRemain-info.remain+1) ],MIN___,[NSNumber numberWithLongLong:totalRemain],MAX___, nil];
            [map setObject:dict forKey:[NSNumber numberWithInteger:info.rwID]];
        }
        
         
    }
    
    
    NSInteger _random = 0;
    
    if (totalRemain >0)
    {
        srand(time(NULL));
        _random = random()% (totalRemain) + 1;
        
        for (int i = 0; i< listRewards.count; i++)
        {
            RewardInfo *info = [listRewards objectAtIndex:i];
            
            NSDictionary* dict = [map objectForKey:[NSNumber numberWithInteger:info.rwID]];
            
            if (dict)
            {
                int min = [[dict objectForKey: MIN___] intValue];
                int max = [[dict objectForKey: MAX___] intValue];
                if ((_random >= min) && (_random <= max))
                {
                    if (info.rwID != lastInfo.rwID)
                    {
                        if (info.remain > 0)
                        {
                            info.played +=1;
                            info.remain -=1;
                            info.numberOfCurrentPlayed +=1;
                        }
                    }
                    else {
                        info.remain -=1;
                        info.played +=1;
                        info.numberOfCurrentPlayed +=1;
                    }
                    return info;
                }

            }
           
        }
        
        lastInfo.remain -=1;
        lastInfo.played +=1;
        lastInfo.numberOfCurrentPlayed +=1;
        return lastInfo;
    }
    else {
        lastInfo.remain -=1;
        lastInfo.played +=1;
        lastInfo.numberOfCurrentPlayed +=1;
        return lastInfo;
    }
    return nil;
    
    
}
@end
