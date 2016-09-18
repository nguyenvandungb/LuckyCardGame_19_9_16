//
//  SettingViewController.h
//  DemoCasino


#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ChangePasscodeViewController.h"
#import "SettingCell.h"
#import "SettingsTimeViewController.h"


@class  InputDataViewController;

#define kDisableInvalidMessage @"末等を含め最低3つ選択して下さい。"
#define kMailSubject @"ログファイル送信"
#define kMailContent @"添付ファイル"

#import "AppViewController.h"
@interface SettingViewController : AppViewController<MFMailComposeViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,SettingCellDelegate> {
	
	IBOutlet UITextField *textfield;
	
	UIButton *checkEstablish;
	UIButton *unCheckEstablish;

	
	UIButton *btnFullScreen;
	
	IBOutlet UIView *viewSetting;
    ChangePasscodeViewController *_changePassView;
    
}
@property (weak, nonatomic) IBOutlet UIButton *timeSettingButton;
@property (retain, nonatomic) IBOutlet UITableView *tbView;
@property (retain, nonatomic) IBOutlet InputDataViewController *inputViewData;

@property (nonatomic,retain) IBOutlet UILabel *lblTotal1;
@property (nonatomic,retain) IBOutlet UILabel *lblTotal2;
@property (nonatomic,retain) IBOutlet UILabel *lblTotal3;


@property (nonatomic,retain) IBOutlet UIButton *checkEstablish;
@property (nonatomic,retain) IBOutlet UIButton *unCheckEstablish;


@property (nonatomic, retain) IBOutlet UIButton *btnSendEmail;
-(void) updateViewSetting;
- (void) selectBtnCheck: (BOOL) _unEstablish andEstablish: (BOOL) _establish;

#pragma mark -
#pragma mark IBAction method
-(IBAction) exitSettingView;

-(IBAction) clearDataWin;
-(IBAction) btnCheckClick;
-(IBAction) btnUnCheckClick;
-(IBAction) btnEnableReward: (id) sender;

//send mail
-(IBAction) showPicker;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

//full screen
-(IBAction) showFullScreen:(id) sender;
-(IBAction) clearCSVfile:(id) sender;
- (IBAction)timeSettingButtonAction:(id)sender;
@end
