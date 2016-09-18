//
//  ChangePasscodeViewController.m
//  PhotoSlot
//
//  Created by ITD on 9/13/11.
//  Copyright 2011 Vsi-International. All rights reserved.
//

#import "ChangePasscodeViewController.h"
#import "Service.h"

@interface ChangePasscodeViewController (private)

- (void) _savePassCodeSussefull;
- (void) _ShowMessageSussefull;
- (void) _checkOldPasscode;
- (void) _ValiatePasscode;
- (void) _CheckMatchPasscode;
@end
//------------------------------------------------------------------------------

@implementation ChangePasscodeViewController

@synthesize txtOldPasscode =_txtOldPasscode;
@synthesize txtNewPasscode =_txtNewPasscode;
@synthesize txtReNewPasscode =_txtReNewPasscode;
@synthesize lblErrorMsg =_lblErrorMsg;
@synthesize btnEnter =_btnEnter;
@synthesize btnClose =_btnClose;


//------------------------------------------------------------------------------
- (IBAction) saveChangePassCode{
    [self _ValiatePasscode];
    
    _txtOldPasscode.text = @"";
    _txtNewPasscode.text = @"";
    _txtReNewPasscode.text = @"";
    [_txtOldPasscode becomeFirstResponder];
}
//------------------------------------------------------------------------------
- (IBAction) closeChangePassView{

    [self.view removeFromSuperview];

}
//------------------------------------------------------------------------------

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lblErrorMsg.hidden = TRUE;
}
//------------------------------------------------------------------------------
- (void) _checkOldPasscode{
    NSString *passcode = [Service loadPasscode];
	_lblErrorMsg.hidden = TRUE;
   
    NSString *iPasscode = _txtOldPasscode.text;
    if([iPasscode isEqualToString:passcode]) {	
        [self _CheckMatchPasscode];
    } else {
        _lblErrorMsg.hidden = FALSE;
        _lblErrorMsg.text = kWrongPasscodeMessage;
        return;
    }	
}
//------------------------------------------------------------------------------
- (void) _ValiatePasscode{
    if (([_txtOldPasscode.text length] == 4) && 
        ([_txtNewPasscode.text length] == 4) && 
        ([_txtReNewPasscode.text length]== 4)) {
        [self _checkOldPasscode];
    }else{
        _lblErrorMsg.hidden = FALSE;
        _lblErrorMsg.text = kPasscodeValidate;
    }
        
}
//------------------------------------------------------------------------------
- (void) _CheckMatchPasscode{
    if ([_txtNewPasscode.text isEqualToString:_txtReNewPasscode.text]) {
        [self _savePassCodeSussefull];
    }else{
        _lblErrorMsg.hidden = FALSE;
        _lblErrorMsg.text = kPassCodeNotMatch;
    }
        
}
//------------------------------------------------------------------------------
- (void) _savePassCodeSussefull{
    NSString *passcode = [NSString stringWithFormat:@"%@",_txtNewPasscode.text];
    [Service changePasscode:passcode];
    
    [self _ShowMessageSussefull];
    
    [self.view removeFromSuperview];
}
//------------------------------------------------------------------------------
- (void) _ShowMessageSussefull{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認" 
                                                    message:@"パスワードが変更されました。" 
                                                   delegate:self 
                                          cancelButtonTitle:@"閉じる" 
                                          otherButtonTitles:nil];
    [alert show];
}
//------------------------------------------------------------------------------
#pragma --
#pragma UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 4) ? NO : YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation== UIInterfaceOrientationLandscapeRight))
    {
        return YES;
    }
    return NO;
    
}
@end
