//
//  InputView.m
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import "InputView.h"
#import "TimeObject.h"
#import "SettingsTimeViewController.h"

@implementation InputView
@synthesize delegate;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSMutableArray *)listOfRewards
{
    if (!_listOfRewards){
        _listOfRewards = [[NSMutableArray alloc] init];
    }
    if (_listOfRewards.count ==0){
        NSArray *arrs = [Reward MR_findAllSortedBy:@"rwID" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"isEnable = %d",1] inContext:[NSManagedObjectContext MR_defaultContext]];
        for (int i  =0; i < arrs.count ; i++) {
            Reward *__mo = [arrs objectAtIndex:i];
            [_listOfRewards addObject:[[RewardInfo alloc]initWithCoreData:__mo]];
        }
    }
    return _listOfRewards;
}

- (void) initInputView
{
    [self getCurrentDateTime];
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    if (rows >0){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        InputCell *cell = (InputCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell.checkImageView setHidden:NO];
    }
}
- (void) getCurrentDateTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    NSString *time = [dateFormat stringFromDate:[self.timePicker date]];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *date = [dateFormat stringFromDate:[self.datePicker date]];
    
    [self.timeButton setTitle:time forState:UIControlStateNormal];
    
    [self.dateButton setTitle:date forState:UIControlStateNormal];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listOfRewards.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self autoSelectFirstItemIfNeed];
    return 1;
}

- (void) autoSelectFirstItemIfNeed {
    if (self.listOfRewards.count ==0) {
        return;
    }
    BOOL existed = NO;
    for (RewardInfo *info in self.listOfRewards) {
        if (info.isChecked) {
            existed = YES;
            break;
        }
    }
    if (existed ==NO) {
        RewardInfo *info = [self.listOfRewards objectAtIndex:0];
        info.isChecked = YES;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [AppDelegate shareInstance];
    static NSString *unikey = @"prizeItem";
    InputCell *cell = (InputCell *)[self.tableView dequeueReusableCellWithIdentifier:unikey];
    if (!cell){
        NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"InputCell" owner:self options:nil];
        if (cells && cells.count >0){
            cell = [cells objectAtIndex:0];
        }
    }
    
    if (cell){
        cell.checkImageView.hidden = YES;
        cell.Titlelabel.text =@"";
        cell.Titlelabel.font = [UIFont boldSystemFontOfSize:16];
        cell.delegate = self;
        cell.tag = indexPath.row;
        if (indexPath.row %2 !=0){
            [cell.cellView setBackgroundColor:[UIColor colorWithRed:183.0/255.0
                                                              green:183.0/255.0
                                                               blue:183.0/255.0 alpha:1.0]];
        }
        if (indexPath.row <self.listOfRewards.count){
            RewardInfo *info = [self.listOfRewards objectAtIndex:indexPath.row];
            if (info){
                cell.tag  = indexPath.row;
                cell.Titlelabel.text = info.name;
                cell.checkImageView.hidden  = !(info.isChecked);
            }
        }
        
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row < self.listOfRewards.count){
        [self.listOfRewards makeObjectsPerformSelector:@selector(deselect)];
        RewardInfo *info = [self.listOfRewards objectAtIndex:indexPath.row];
        info.isChecked = YES;
        [self.tableView reloadData];
    }
}

#pragma --mark input cell delegate
- (void) didTapOnInputCell:(InputCell *)acell {
    
}

- (RewardInfo *) checkRewardInfo {
    for (RewardInfo *info in self.listOfRewards) {
        if (info.isChecked){
            return info;
        }
    }
    return nil;
}

- (IBAction)createButtonAction:(id)sender {
    [self getCurrentDateTime];
    RewardInfo *info = [self checkRewardInfo];
    if (info){
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        [dateFormat setDateFormat:@"HH:mm:ss:SSSZZZZ"];
        NSString *time = [dateFormat stringFromDate:[self.timePicker date]];
        [dateFormat setDateFormat:@"yyyy/MM/dd"];
        NSString *datestr = [dateFormat stringFromDate:[self.datePicker date]];
        
        NSString *str = [datestr stringByAppendingFormat:@" %@",time];
        [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSSZZZZ"];
        NSDate *date = [dateFormat dateFromString:str];
        TimeObject *tObject = [[TimeObject alloc]init];
        tObject.unikey = [Utils generateUUID];
        tObject.timeInterval = [date timeIntervalSince1970];
        tObject.dateSetup = self.dateButton.titleLabel.text;
        tObject.timeSetup = self.timeButton.titleLabel.text;
        tObject.dateWin = @"";
        tObject.timeWin = @"";
        tObject.rewardID = (int)info.rwID;
        tObject.isSelected = [[(SettingsTimeViewController *)delegate selectAllButton] isSelected];
        NSArray *arr= [Time MR_findAll];
        int count = (int)((arr)?arr.count:0);
        tObject.index = count+1;
        [tObject saveToDatabase];
        [[AppDelegate shareInstance] saveContext:^(BOOL success) {
            if (delegate && [delegate respondsToSelector:@selector(didTapOnCreateButton:newTimeInfo:)])
            {
                [delegate didTapOnCreateButton:self newTimeInfo:tObject];
            }
        }];
    }
    
    [self.datePicker setDate:[NSDate date] ];
    [self.timePicker setDate:[NSDate date]];
    [self getCurrentDateTime];
}
/*! Returns the major version of iOS, (i.e. for iOS 6.1.3 it returns 6)
 */
NSUInteger DeviceSystemMajorVersion()
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    
    return _deviceSystemMajorVersion;
}

#define EMBEDDED_DATE_PICKER (DeviceSystemMajorVersion() >= 7)
- (IBAction)closeButtonAction:(id)sender {

    if (delegate && [delegate respondsToSelector:@selector(didTapOnCloseButton:)])
    {
        [delegate didTapOnCloseButton:self];
    }
}

- (IBAction)dateSettingAction:(id)sender {
    [self getCurrentDateTime];
}

- (IBAction)timeSettingAction:(id)sender {
    [self getCurrentDateTime];
}
@end
