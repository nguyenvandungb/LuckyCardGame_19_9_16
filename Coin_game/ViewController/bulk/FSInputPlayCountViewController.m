//
//  FSInputPlayCountViewController.m
//  roulette
//
//  Created by FSIOSTeam on 11/3/12.
//  Copyright (c) 2012 FSIOSTeam. All rights reserved.
//

#import "FSInputPlayCountViewController.h"
#import "PlayViewController.h"
#import "SettingViewController.h"
#import "FSGoHomView.h"
#define kOFFSET_FOR_KEYBOARD 175
static FSInputPlayCountViewController *_controller = nil;
@interface FSInputPlayCountViewController ()

@end

@implementation FSInputPlayCountViewController
@synthesize mainView;
@synthesize keyboardController = _keyboardController;
@synthesize goHome =_goHome;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    _controller = self;
    return _controller;
}
+ (FSInputPlayCountViewController *) shareInstance
{
    if (!_controller)
    {
        _controller = [[FSInputPlayCountViewController alloc] initWithNibName:@"FSInputPlayCountViewController" bundle:nil];
    }
    return _controller;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    self.numPlayTextField.delegate = self;
    self.numPlayTextField.text = @"1";

    _goHome = [[FSGoHomView alloc] initWithParentViewController:self];
    [self.goHome show];
    CGRect rect2 = self.view.frame;
    self.mainView.frame = CGRectMake(0, 0, rect2.size.width, rect2.size.height);
    self.bgImageView.frame = CGRectMake(0, 0, rect2.size.width, rect2.size.height);
    [self.numPlayTextField becomeFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBgImageView:nil];
    [self setNumPlayTextField:nil];
    [super viewDidUnload];
}
- (IBAction)inputTextBegin:(id)sender
{
    [self setViewMovedUp:YES];
    return;
}

- (IBAction)inputTextDidEnd:(id)sender
{
    [self setViewMovedUp: NO];
    
    
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
        return YES;
    
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setViewMovedUp:NO];
    [self.numPlayTextField resignFirstResponder];
    return YES;
}
//method to move the view up/down whenever the keyboard is shown/dismissed
- (void)setViewMovedUp:(BOOL)movedUp
{
    return;
    moveViewUp = movedUp;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.mainView.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        rect.origin.y -= 70;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y  =0;
    }
    self.mainView.frame = rect;
    
    [UIView commitAnimations];
}
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!moveViewUp)
    {
        _keyboardController = [[FSSTDNumberKeyboardViewController alloc] initWithNibName:@"FSSTDNumberKeyboardViewController" bundle:nil];
        self.keyboardController.keyboardDelegate = self;
        CGRect r = self.keyboardController.view.frame;
        CGRect mrect = self.view.frame;
        
        r.origin.y = mrect.size.height;
        r.origin.x = 0;
        self.keyboardController.view.frame  = r;
        [self.view addSubview: self.keyboardController.view];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        r.origin.y -= r.size.height;
        self.keyboardController.view.frame =r;
        
        [UIView commitAnimations];
        [self setViewMovedUp:YES];
        return NO;
 
    }
    return NO;
}

- (void) didPressedNumber:(NSString *)_numbers
{
    self.numPlayTextField.text = (_numbers)?_numbers:@"";
}
- (void) didDeleteNumber :(NSString *)_numbers
{
    if (!_numbers  || _numbers.length ==0 || [_numbers isEqualToString:@"0"]){
        _numbers = @"1";
    }
    self.numPlayTextField.text = (_numbers)?_numbers:@"";
}
- (void) didReturnPressed :(FSSTDNumberKeyboardViewController *)_keyboardController
{
    NSInteger count = [self.numPlayTextField.text integerValue];
    if (count == 0)
    {
        return;
    }
    [self.numPlayTextField resignFirstResponder];
    AppDelegate *app = [AppDelegate shareInstance];
    [app playSound:app.buttonSound];
    
    PlayViewController *controller = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"PlayViewController"];
    controller.playCount =  count;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma --mark FS Goto home delegate
- (void) didDoubleTapOnGoHomeView:(FSGoHomView *)_aview
{
    [_aview removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
