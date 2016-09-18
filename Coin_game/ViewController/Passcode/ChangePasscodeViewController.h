//
//  ChangePasscodeViewController.h
//  PhotoSlot
//
//  Created by ITD on 9/13/11.
//  Copyright 2011 Vsi-International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasscodeViewController : UIViewController {
    
}
@property (nonatomic, retain) IBOutlet UITextField *txtOldPasscode;
@property (nonatomic, retain) IBOutlet UITextField *txtNewPasscode;
@property (nonatomic, retain) IBOutlet UITextField *txtReNewPasscode;

@property (nonatomic, retain) IBOutlet UILabel *lblErrorMsg;
@property (nonatomic, retain) IBOutlet UIButton *btnEnter;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;

- (IBAction) saveChangePassCode;
- (IBAction) closeChangePassView;
@end
