//
//  PopoverViewController.h
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/11/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol editDateTimeProtocol<NSObject>
- (void) tappedOnDoneButton:(NSString *)result;
- (void) tappedOnCancelButton;
@end
@interface PopoverViewController : UIViewController
{
    
}

@property (nonatomic, assign) UIDatePickerMode          mode;
@property (nonatomic, assign) id <editDateTimeProtocol>   delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;


- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
