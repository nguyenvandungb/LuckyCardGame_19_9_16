//
//  LoginViewController.h
//  DemoCasino

#import <UIKit/UIKit.h>

#import "PasscodeView.h"
#import "AppViewController.h"
#import "FSInputPlayCountViewController.h"

@interface LoginViewController : AppViewController<PasscodeDelegate>
{
     BOOL                _isShowingPasscode;
    CGPoint		                             gestureStartPoint;
    PasscodeView                            *passcodeView;
}
@property (nonatomic, retain) IBOutlet PasscodeView              *passcodeView;
@property (retain, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;
@property (retain, nonatomic) IBOutlet UIImageView *bgView;
-(IBAction) startGame;
- (IBAction)startButtonAction:(id)sender;
- (IBAction)swipeAction:(id)sender;
- (void) didValidPasscode;
- (void) didCancelLogin;
@end
