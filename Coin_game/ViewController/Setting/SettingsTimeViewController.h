//
//  SettingsTimeViewController.h
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingTimeCell.h"
#import "InputView.h"
#import "PopoverViewController.h"
#import "AppViewController.h"

@interface SettingsTimeViewController : AppViewController
<UITableViewDataSource, UITableViewDelegate,SettingTimeCellDelegate,InputViewDelegate,UIPopoverControllerDelegate,editDateTimeProtocol>
{
    
}

@property (nonatomic, retain) UIPopoverController       *popController;
@property (nonatomic, retain) TimeObject            *editingObject;
@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;
@property (retain, nonatomic) PopoverViewController         *poverViewController;


@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (strong, nonatomic) IBOutlet InputView *inputView;
@property (weak, nonatomic) IBOutlet UIView *settingView;


- (IBAction)settingDateAcion:(id)sender;
- (IBAction)settingTimeAction:(id)sender;

- (IBAction)saveButtonAction:(id)sender;
- (IBAction)deleteButtonAction:(id)sender;
- (IBAction)backButtonAction:(id)sender;
- (IBAction)selectAllButtonAction:(id)sender;

@end
