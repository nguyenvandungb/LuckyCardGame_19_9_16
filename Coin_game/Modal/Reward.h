//
//  Reward.h
//  LuckyPadSony
//
//  Created by dungnv9 on 1/25/15.
//  Copyright (c) 2015 Applekikaku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RewardInfo;
@interface Reward : NSManagedObject

@property (nonatomic, retain) NSNumber * isEnable;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rwID;
@property (nonatomic, retain) NSNumber * played;
@property (nonatomic, retain) NSNumber * remain;
@property (nonatomic, retain) NSNumber * total;
- (void) fillDataFrom:(RewardInfo *)info;
@end
