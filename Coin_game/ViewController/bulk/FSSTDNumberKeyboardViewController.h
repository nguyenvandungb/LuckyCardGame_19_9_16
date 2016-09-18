//
//  FSSTDNumberKeyboardViewController.h
//  roulette
//
//  Created by FSIOSTeam on 11/5/12.
//  Copyright (c) 2012 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppViewController.h"

@class FSSTDNumberKeyboardViewController;
@protocol StandardNumberKeyboardDelegate<NSObject>
@required
- (void) didPressedNumber:(NSString *)_numbers;
- (void) didDeleteNumber :(NSString *)_numbers;
- (void) didReturnPressed :(FSSTDNumberKeyboardViewController *)_keyboardController;
@end
@interface FSSTDNumberKeyboardViewController : AppViewController
{
    NSMutableArray                  *_digitals;
    __unsafe_unretained id <StandardNumberKeyboardDelegate>  _keyboardDelegate;
}

@property (nonatomic, retain) NSMutableArray            *digitals;
@property (nonatomic, unsafe_unretained)  id<StandardNumberKeyboardDelegate>   keyboardDelegate;

@property (strong, nonatomic) IBOutlet UIButton *btnNum1;
@property (strong, nonatomic) IBOutlet UIButton *btnNum2;
@property (strong, nonatomic) IBOutlet UIButton *btnNum3;
@property (strong, nonatomic) IBOutlet UIButton *btnNum4;
@property (strong, nonatomic) IBOutlet UIButton *btnNum5;
@property (strong, nonatomic) IBOutlet UIButton *btnNum6;
@property (strong, nonatomic) IBOutlet UIButton *btnNum7;
@property (strong, nonatomic) IBOutlet UIButton *btnNum8;
@property (strong, nonatomic) IBOutlet UIButton *btnNum9;
@property (strong, nonatomic) IBOutlet UIButton *btnNum0;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIButton *btnReturn;


- (IBAction)action:(id)sender;

@end
