//
//  FSInputPlayCountViewController.h
//  roulette
//
//  Created by FSIOSTeam on 11/3/12.
//  Copyright (c) 2012 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSSTDNumberKeyboardViewController.h"
#import "FSGoHomView.h"

@class FSGoHomView;
@interface FSInputPlayCountViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,StandardNumberKeyboardDelegate,FSHomeViewDelegate>
{
    BOOL moveViewUp;
    UIView              *mainView;
    FSSTDNumberKeyboardViewController           *_keyboardController;
    BOOL                        didTap;
    FSGoHomView                 *_goHome;
}


@property (nonatomic, retain) FSGoHomView                 *goHome;
@property (nonatomic, retain) FSSTDNumberKeyboardViewController           *keyboardController;
@property (nonatomic, retain) IBOutlet UIView                *mainView;
@property (assign, nonatomic) IBOutlet UIImageView *bgImageView;
@property (assign, nonatomic) IBOutlet UITextField *numPlayTextField;
- (IBAction)inputTextBegin:(id)sender;
- (IBAction)inputTextDidEnd:(id)sender;



+ (FSInputPlayCountViewController *) shareInstance;
@end
