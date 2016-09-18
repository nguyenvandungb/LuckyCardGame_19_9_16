//
//  Time.h
//  LuckyPadSony
//
//  Created by dungnv9 on 1/25/15.
//  Copyright (c) 2015 Applekikaku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class TimeObject;

@interface Time : NSManagedObject

@property (nonatomic, retain) NSString * unikey;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * dateSetup;
@property (nonatomic, retain) NSString * timeSetup;
@property (nonatomic, retain) NSString * timeWin;
@property (nonatomic, retain) NSString * dateWin;
@property (nonatomic, retain) NSNumber * rewardID;
@property (nonatomic, retain) NSNumber * isOut;
@property (nonatomic, retain) NSNumber * timeInterval;
@property (nonatomic, retain) NSNumber * isSelected;

- (void) fillDataFrom:(TimeObject *)info;
@end
