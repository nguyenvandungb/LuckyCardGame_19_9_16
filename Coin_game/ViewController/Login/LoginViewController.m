    //
//  LoginViewController.m
//  DemoCasino


#import "LoginViewController.h"
#import "SettingViewController.h"
#import "PlayViewController.h"
#import "Service.h"


@interface LoginViewController()


@property (nonatomic, retain) SettingViewController             *settingController;
- (IBAction)playAllAction:(id)sender;
- (IBAction)playOneAction:(id)sender;

@end

@implementation LoginViewController
@synthesize settingController = _settingController;


@synthesize passcodeView;


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        return YES;
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (TESTING ==1) {
        _isShowingPasscode = NO;
        [self startButtonAction:nil];
    }
}

- (void) didValidPasscode {
    
    [self.passcodeView removeFromSuperView];
    _isShowingPasscode= NO;
    if (_settingController){
        self.settingController = nil;
    }
    _settingController = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    _settingController.view.hidden =NO;
    [_settingController updateViewSetting];
    if ([[self.navigationController viewControllers]  containsObject:_settingController])
    {
        [self.navigationController popToViewController:_settingController animated:YES];
    }
    else {
        [self.navigationController pushViewController:_settingController animated:YES];
    }
}

- (void) didCancelLogin
{
    
    [self.passcodeView removeFromSuperView];
    _isShowingPasscode =NO;
}


- (void) viewWillUnload
{

    [super viewWillUnload];
    
}

//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) startGame {
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *app = [AppDelegate shareInstance];
        [app playSound:app.buttonSound];
        PlayViewController *controller = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    });
}

- (IBAction)startButtonAction:(id)sender {
    if (_isShowingPasscode){
        return;
    }
    [self startGame];
}

- (IBAction)swipeAction:(id)sender {
    
    self.passcodeView.delegate = self;
    CGRect r = self.view.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    self.passcodeView.frame = r;
    [[AppDelegate shareInstance].window.rootViewController.view addSubview: self.passcodeView];
    [self.passcodeView makeResponder];
    //[self.view bringSubviewToFront:self.passcodeView];
    _isShowingPasscode = YES;
}

//------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark dealloc



- (void)viewDidUnload {
    [self setBgView:nil];
    [self setSwipeGesture:nil];
    [super viewDidUnload];
}

- (IBAction)playAllAction:(id)sender {
    [AppDelegate shareInstance].gameType = TYPE_PLAY_ALL;
    [self gotoInputBulkValueScreen];
}

- (IBAction)playOneAction:(id)sender {
    [AppDelegate shareInstance].gameType = TYPE_PLAY_ONE;
    [self gotoInputBulkValueScreen];
}

- (void)gotoInputBulkValueScreen {
    AppDelegate *app = [AppDelegate shareInstance];
    long long totalRemain = 0;
    BOOL  _isShowAlert = [Service getEstablishBool];
    NSArray *arr = [Reward MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"isEnable = %d",1] inContext:[NSManagedObjectContext MR_defaultContext]];
    for (int i = 0 ; i <[arr count]; i++)
    {
        Reward *__mo = [arr objectAtIndex:i];
        RewardInfo *info = [[RewardInfo alloc] initWithCoreData:__mo];
        totalRemain += info.remain;
    }
    
    if (totalRemain <=0 && _isShowAlert)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"アラート"
                                                            message:@"残り本数がなくなりました。"
                                                           delegate:self
                                                  cancelButtonTitle:@"閉じる"
                                                  otherButtonTitles:nil, nil];
        alertView.delegate = self;
        [alertView show];
        return;
    }

    FSInputPlayCountViewController *controller = [[FSInputPlayCountViewController alloc] initWithNibName:@"FSInputPlayCountViewController" bundle:nil];
    controller.numPlayTextField.text = @"0";
    [self.navigationController pushViewController:controller animated:YES];
}

@end
