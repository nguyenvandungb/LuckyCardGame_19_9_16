//
//  PopoverViewController.m
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/11/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController ()

@end

@implementation PopoverViewController
@synthesize delegate;
@synthesize mode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.picker.datePickerMode = mode;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPicker:nil];
    [super viewDidUnload];
}
- (IBAction)doneAction:(id)sender {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    NSString *result = @"";
    if (self.picker.datePickerMode == UIDatePickerModeDate){
        [dateFormat setDateFormat:@"yyyy/MM/dd"];
        result = [dateFormat stringFromDate:[self.picker date]];
    }else if (self.picker.datePickerMode == UIDatePickerModeTime){
        [dateFormat setDateFormat:@"HH:mm:ss"];
        result = [dateFormat stringFromDate:[self.picker date]];
    }
    
    if (delegate && [delegate respondsToSelector:@selector(tappedOnDoneButton:)]){
        [delegate tappedOnDoneButton: result];
    }
    
}

- (IBAction)cancelAction:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(tappedOnCancelButton)]){
        [delegate tappedOnCancelButton];
    }
}
@end
