//
//  SettingTimeCell.h
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeObject.h"
@class SettingTimeCell;
@protocol SettingTimeCellDelegate <NSObject>
- (void) tappedOnChoiceButton:(SettingTimeCell *)cell isChoice:(BOOL) isChoice;
- (void) tappedOnEditDateColumn:(SettingTimeCell *)cell;
- (void) tappedOnEditTimeColumn:(SettingTimeCell *)cell;

@end

@interface SettingTimeCell : UITableViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (assign, nonatomic) id <SettingTimeCellDelegate > delegate;
@property (weak, nonatomic) IBOutlet UILabel *orderIndexLabel;
@property (weak, nonatomic) IBOutlet UIButton *setupDateButton;
@property (weak, nonatomic) IBOutlet UIButton *setupTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *prizeNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *winDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *winTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *choiceButton;
@property (nonatomic, strong) TimeObject        *timeObject;
- (IBAction)choiceButtonAction:(id)sender;
- (void) displayContent:(TimeObject *)tObject;
- (IBAction)editDateAction:(id)sender;
- (IBAction)editTimeAction:(id)sender;




@end
