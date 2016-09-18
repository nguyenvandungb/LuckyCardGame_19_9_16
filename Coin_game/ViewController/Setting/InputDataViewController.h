//
//  InputDataViewController.h
//  DemoCasino

#import <UIKit/UIKit.h>
#import "SettingViewController.h"
@class RewardInfo;
@interface InputDataViewController : UIView {


	UILabel *lable;
	//UILabel *label2;	
	//UIImageView *imageInputName;
	
	SettingViewController *settingView;
	NSInteger valueObj;
	
	IBOutlet UIView *viewSubInput;
}

@property (nonatomic, retain) IBOutlet 	UILabel *lable;
//Add by QuyPV for new req 04/08/2011
@property (nonatomic, retain) IBOutlet UITextField *hazureName;

- (void) loadSettingViewController: (RewardInfo *)info;

#pragma mark -
#pragma mark IBOutlet Method

-(IBAction) exitInputData;
-(IBAction) clearLable;
-(IBAction) addNumberlabler_1;
-(IBAction) addNumberlabler_2;
-(IBAction) addNumberlabler_3;
-(IBAction) addNumberlabler_4;
-(IBAction) addNumberlabler_5;
-(IBAction) addNumberlabler_6;
-(IBAction) addNumberlabler_7;
-(IBAction) addNumberlabler_8;
-(IBAction) addNumberlabler_9;
-(IBAction) addNumberlabler_0;

@end
