//
//  RewardInfo.h
//  roulette
//
//  Created by FSIOSTeam on 11/3/12.
//  Copyright (c) 2012 FSIOSTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Reward;

@interface RewardInfo : NSObject
{
    long          _numberOfCurrentPlayed;
}
@property (nonatomic, assign) BOOL       isTimingObj;
@property (nonatomic, assign) BOOL          isEnable;
@property (nonatomic, retain) NSString  *name;
@property (nonatomic, assign) NSInteger  rwID;
@property (nonatomic, assign) NSInteger  played;
@property (nonatomic, assign) NSInteger  remain;
@property (nonatomic, assign) NSInteger  total;
@property (nonatomic, assign) long      numberOfCurrentPlayed;
@property (nonatomic, assign) BOOL      isChecked;
- (void) showLog;
- (void) deselect;
- (void) saveToCoreData;
- (void) saveToCoreDataWithPlayedTime:(NSInteger)nb;
- (id) initWithCoreData:(Reward *)info;
- (id)copyWithZone:(NSZone *)zone;
@end
