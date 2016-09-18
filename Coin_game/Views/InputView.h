//
//  InputView.h
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputCell.h"
@class TimeObject;
@class InputView;
@protocol InputViewDelegate<NSObject>
- (void) didTapOnCloseButton:(InputView *)aview;
- (void) didTapOnCreateButton:(InputView *)aview newTimeInfo:(TimeObject *)info;
@end
@interface InputView : UIView
<UITableViewDataSource, UITableViewDelegate,InputCellDelegate>
{

}
@property (assign, nonatomic) id <InputViewDelegate > delegate;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) NSMutableArray *listOfRewards;
@property (weak, nonatomic) IBOutlet UIView *dateContainer;
- (void) initInputView;
- (IBAction)createButtonAction:(id)sender;
- (IBAction)closeButtonAction:(id)sender;
- (IBAction)dateSettingAction:(id)sender;
- (IBAction)timeSettingAction:(id)sender;


@end
