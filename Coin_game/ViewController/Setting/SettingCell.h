//
//  SettingCell.h
//  LuckyPad_Koala
//
//  Created by dung nguyen van on 3/12/14.
//  Copyright (c) 2014 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RewardInfo;
@class SettingCell;
@protocol SettingCellDelegate <NSObject>

- (void) SettingCellWillUpdateValue:(SettingCell *)cell;
- (void) SettingCellEnableDisableBtnPressed:(SettingCell *)cell;

@end
@interface SettingCell : UITableViewCell
{
    
}


@property (nonatomic, assign) id <SettingCellDelegate>      delegate;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UIButton *btn;
@property (retain, nonatomic) IBOutlet UIButton *enableBtn;
@property (retain, nonatomic) IBOutlet UILabel *total;
@property (retain, nonatomic) IBOutlet UILabel *played;
@property (retain, nonatomic) IBOutlet UILabel *remain;
@property (strong, nonatomic) RewardInfo *info;


- (IBAction)showKeyboardAction:(id)sender;
- (IBAction)enableOrDisableAction:(id)sender;

- (void) displayWithInfo:(RewardInfo *)obj;

+ (SettingCell *) newSettingCell;
@end
