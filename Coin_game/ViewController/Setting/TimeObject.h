//
//  TimeObject.h
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Time;
@interface TimeObject : NSObject
{
    
}
@property (nonatomic, assign) double        timeInterval;
@property (nonatomic, copy) NSString        *unikey;
@property (nonatomic, assign) int           index;
@property (nonatomic, copy)  NSString       *dateSetup;
@property (nonatomic, copy)  NSString       *timeSetup;
@property (nonatomic, copy)  NSString       *timeWin;
@property (nonatomic, copy)  NSString       *dateWin;
@property (nonatomic, assign)  int          rewardID;
@property (nonatomic, assign) BOOL          isOut;

@property (nonatomic, assign)  BOOL         isSelected;
- (void) select;
- (void) deselect;
- (void) saveToDatabase;
- (id) initWithCoreData:(Time *)info;
@end
