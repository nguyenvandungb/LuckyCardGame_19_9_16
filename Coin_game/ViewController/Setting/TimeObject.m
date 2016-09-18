//
//  TimeObject.m
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import "TimeObject.h"

@implementation TimeObject

@synthesize dateSetup = _dateSetup;
@synthesize dateWin = _dateWin;
@synthesize index =_index;
@synthesize rewardID = _rewardID;
@synthesize timeSetup = _timeSetup;
@synthesize timeWin = _timeWin;
@synthesize unikey = _unikey;
@synthesize isSelected = _isSelected;
@synthesize isOut = _isOut;
- (void) select
{
    _isSelected = YES;
}
- (void) deselect
{
    _isSelected = NO;
}
- (void) setIsSelected:(BOOL)Selected
{
    _isSelected = Selected;
}

- (void) setIsOut:(BOOL)flag
{
    _isOut = flag;
}
- (id) initWithCoreData:(Time *)info{
    if (!info){
        return nil;
    }
    self = [super init];
    if (self){
        _dateSetup = info.dateSetup;
        _dateWin = info.dateWin;
        _index = [info.index intValue];
        _rewardID = [info.rewardID intValue];
        _timeSetup = info.timeSetup;
        _timeWin = info.timeWin;
        _unikey = info.unikey;
        _isOut = [info.isOut  boolValue];
        _timeInterval = [info.timeInterval doubleValue];
        _isSelected = [info.isSelected boolValue];
    }
    return self;

}

- (void) saveToDatabase
{
    Time * __mo = [Time MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"unikey=%@",self.unikey] inContext:[NSManagedObjectContext MR_defaultContext]];
    if (!__mo) {
        __mo = [Time MR_createInContext:[NSManagedObjectContext MR_defaultContext]];
    }
    [__mo fillDataFrom:self];
}
@end
