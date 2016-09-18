//
//  PasscodeViewController.h
//  GameCasino
//
//  Created by Quy Pham Van on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

//#define kPasscode 1234
//#define kBlankPasscodeMessage @"パスワードを入力してください"
//#define kWrongPasscodeMessage @"パスワードが違います"
@protocol PasscodeDelegate<NSObject>
- (void) didValidPasscode;
- (void) didCancelLogin;
@end

@interface PasscodeView : UIView {
	SettingViewController * settingView;
	UITextField *txtPasscode;
	UILabel *lblErrorMsg;

	UIButton *btnClose;
	UIButton *btnEnter;
}
@property (nonatomic, unsafe_unretained) id <PasscodeDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *txtPasscode;
@property (nonatomic, retain) IBOutlet UILabel *lblErrorMsg;
@property (nonatomic, retain) IBOutlet UIButton *btnEnter;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;
- (void) makeResponder;
- (IBAction) showSettingView;
- (IBAction) closePasscodeView;
- (void) removeFromSuperView;
@end
