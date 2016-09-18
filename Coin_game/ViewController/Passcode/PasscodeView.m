//
//  PasscodeViewController.m
//  GameCasino
//
//  Created by Quy Pham Van on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PasscodeView.h"
#import "Service.h"

@implementation PasscodeView
@synthesize txtPasscode,lblErrorMsg, btnEnter, btnClose;
@synthesize delegate = _delegate;

//------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction) showSettingView;
{
    NSString *passcode = [Service loadPasscode];
    
	lblErrorMsg.hidden = TRUE;
	
	if([txtPasscode.text length] == 0) {
		lblErrorMsg.hidden = FALSE;
		lblErrorMsg.text = kBlankPasscodeMessage;
	} else {
		NSString *iPasscode = txtPasscode.text;
		if([iPasscode isEqualToString:passcode]) {
			[self.delegate didValidPasscode];
		} else {
			lblErrorMsg.hidden = FALSE;
			lblErrorMsg.text = kWrongPasscodeMessage;
		}
	}
}
- (void) resetPasscodeView
{
    self.txtPasscode.text = @"";
    self.lblErrorMsg.text = @"";
    
}
- (void) makeResponder
{
    self.lblErrorMsg.text = @"";
    [self bringSubviewToFront:self.btnClose];
    [self bringSubviewToFront:self.btnEnter];
    [self.txtPasscode becomeFirstResponder];
}
- (void) removeFromSuperView
{
    [self resetPasscodeView];
    [self removeFromSuperview];
}
- (IBAction) closePasscodeView;
{
	lblErrorMsg.hidden = TRUE;
	lblErrorMsg.text = @"";
	txtPasscode.text = @"";	
	[self.delegate didCancelLogin];
}



//------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
#pragma --
#pragma UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 4) ? NO : YES;
}

@end
