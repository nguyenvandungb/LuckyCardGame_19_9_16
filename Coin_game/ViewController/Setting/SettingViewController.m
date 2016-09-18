    //
//  SettingViewController.m
//  DemoCasino


#import "SettingViewController.h"
#import "Service.h"
#import "InputDataViewController.h"
#import "PasscodeView.h"
#import "Utils.h"
#import "InputView.h"

@interface SettingViewController()<NSFetchedResultsControllerDelegate>
{
    
}
@property (nonatomic, strong) NSFetchedResultsController        *fetchedResultController;
@end

@implementation SettingViewController

@synthesize checkEstablish, unCheckEstablish;
@synthesize inputViewData = _inputViewData;
- (IBAction)timeSettingButtonAction:(id)sender {
    
    SettingsTimeViewController *controller= [[SettingsTimeViewController alloc] initWithNibName:@"SettingsTimeViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];

}
- (NSFetchedResultsController *)fetchedResultController
{
    if (!_fetchedResultController){
        NSFetchedResultsController *fetchController = [Reward  MR_fetchAllGroupedBy:@"rwID" withPredicate:nil sortedBy:@"rwID" ascending:YES inContext:[NSManagedObjectContext MR_defaultContext]];
        _fetchedResultController = fetchController;
        _fetchedResultController.delegate = self;
        
    }
    return _fetchedResultController;
}
- (void) dealloc
{
    self.fetchedResultController.delegate = nil;
    self.fetchedResultController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tbView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"SettingCell"];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadSetting:) name:NOTIFICATION_RELOAD_SETTING object:nil];
	
	UIImage *image = [UIImage imageNamed:@"check.png"];
	[checkEstablish setImage:image forState:UIControlStateSelected];
	[unCheckEstablish setImage:image forState:UIControlStateSelected];
	[self selectBtnCheck:![Service getEstablishBool] andEstablish:[Service getEstablishBool]];
    
    
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        return YES;
    }
    return NO;
}

- (void) reloadSetting:(NSNotification *)notify
{
    [self.tbView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self updateViewSetting];
    if ([self.fetchedResultController sections].count >0){
        id  sectionInfo =
        [[self.fetchedResultController sections] objectAtIndex:section];
        NSInteger counter = [sectionInfo numberOfObjects];
        return counter;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultController sections] count];
}

- (void) configCell:(SettingCell *)cell atIndexPath :(NSIndexPath *)indexPath
{
    Reward *__mo = [self.fetchedResultController objectAtIndexPath:indexPath];
    RewardInfo *info = [[RewardInfo alloc] initWithCoreData:__mo];
    cell.tag = info.rwID;
    [cell displayWithInfo:info];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idef = @"SettingCell";
    SettingCell *cell = (SettingCell *)[_tbView dequeueReusableCellWithIdentifier:idef];
    if (!cell){
        cell = [SettingCell newSettingCell];
    }
    if (cell){
        cell.delegate = self;
        [self configCell:cell atIndexPath:indexPath];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void) SettingCellWillUpdateValue:(SettingCell *)cell
{
    
    [self showInputDataImage:cell.info];
}

- (NSInteger) numberOfEnableRewards
{
    NSArray *arr= [Reward MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"isEnable = %d",1] inContext:[NSManagedObjectContext MR_defaultContext]];
    if (arr){
        return arr.count;
    }
    return 0;
}
- (void) SettingCellEnableDisableBtnPressed:(SettingCell *)cell
{
    AppDelegate *app = [AppDelegate shareInstance];
    Reward *__mo = [Reward MR_findFirstWithPredicate:nil sortedBy:@"rwID" ascending:NO];
    if (cell.info.rwID != [__mo.rwID intValue]){
        BOOL isEnable = cell.info.isEnable;
        if (isEnable && [self numberOfEnableRewards] <=3)
        {
            [[FSAlert shareInstance] showAlertWithMessage:kDisableInvalidMessage informativeText:@"" cancelButtonTitle:@"Close" otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
                
            } onCancel:^{
                
            }];
            return;
        }
        else{
            
            cell.info.isEnable = !isEnable;
            cell.enableBtn.selected = !cell.info.isEnable;
            [cell.info saveToCoreData];
            [app saveContext:^(BOOL success) {
                
            }];
        }
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.inputViewData.alpha = 0.0;
    self.inputViewData.hidden = YES;
    [self.tbView reloadData];
}
//------------------------------------------------------------------------------------------------------------------------------------------------
- (void) selectBtnCheck: (BOOL) _unEstablish andEstablish: (BOOL) _establish{
	[checkEstablish setSelected:_establish];
	[unCheckEstablish setSelected:_unEstablish];
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) exitSettingView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SETTING_VIEW_CLOSE object:nil];
    if ([_lblTotal1.text intValue] > 100000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning", "Warning") 
                                                        message:NSLocalizedString(@"Please set the total below 100,000", "100,000 warning") 
                                                       delegate:self 
                                              //cancelButtonTitle:@"閉じる" 
                                              cancelButtonTitle:NSLocalizedString(@"Close", "Close Alert")
                                              otherButtonTitles:nil];
        [alert show];

    }
    else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//------------------------------------------------------------------------------
- (IBAction) changePassCode{
    if (_changePassView!=nil) {
        [_changePassView.view removeFromSuperview];
    }
    _changePassView = [[ChangePasscodeViewController alloc] initWithNibName:@"ChangePasscodeViewController" 
                                                                     bundle:nil];
    [self.view addSubview:_changePassView.view];
}

//------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Rotation support


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


/*
 -lbl01 : total
 - lb02 :played
 - lb03: remain
 
 - setting for all GUI item on view
 
 */
-(void) updateViewSetting
{
    NSArray *arrs = [Reward MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"isEnable = %d",1] inContext:[NSManagedObjectContext MR_defaultContext]];
    
    NSInteger total =  0;
    NSInteger remain = 0;
    NSInteger played = 0;
    for (Reward *info in arrs) {
        total += [info.total integerValue];
        remain += [info.remain integerValue];
        played += [info.played integerValue];
    }
    
	self.lblTotal1.text = [NSString stringWithFormat:@"%d",(int)total];
    self.lblTotal2.text = [NSString stringWithFormat:@"%d",(int)played];
    self.lblTotal3.text = [NSString stringWithFormat:@"%d",(int)remain];
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(void) showInputDataImage: (RewardInfo *) info
{
	[_inputViewData loadSettingViewController:info];
	[self.view bringSubviewToFront:_inputViewData];
    [self.view addSubview:self.inputViewData];
    _inputViewData.hidden = NO;
    [UIView animateWithDuration:.35 animations:^{
        _inputViewData.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}


/*
 purpose: reset data played
 
 */
-(IBAction) clearDataWin
{
    NSArray *arr = [Reward MR_findAll];
    for (Reward *__mo in arr) {
        __mo.played = [NSNumber numberWithInt:0];
        __mo.remain = [NSNumber numberWithInt:[__mo.total intValue]];
    }
	
    [[AppDelegate shareInstance] saveContext:^(BOOL success) {
        
    }];
	[self updateViewSetting];
    [self.tbView reloadData];
	 
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) btnCheckClick{
	[self selectBtnCheck:NO andEstablish:YES];
	[Service saveToEstablishBool:YES];//must to Establish for "win of Number" 
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) btnUnCheckClick{
	[self selectBtnCheck:YES andEstablish:NO];	
	[Service saveToEstablishBool:NO];//Not must to Establish for "win of Number" 
}
//------------------------------------------------------------------------------------------------------------------------------------------------

-(IBAction) btnEnableReward: (id) sender;
{
	
	UIButton *button = (UIButton *) sender;
    NSInteger rewardType = button.tag;
    
    Reward *__mo = [Reward MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"rwID = %d",rewardType] inContext:[NSManagedObjectContext MR_defaultContext]];
    if (__mo){
        RewardInfo *info = [[RewardInfo alloc] initWithCoreData:__mo];
        if (info && info.rwID != max_id)
        {
            BOOL isEnable = info.isEnable;
            if (isEnable && [Service checkIfReachMinNumOfEnableRewards:2])
            {
                [[FSAlert shareInstance] showAlertWithMessage:kDisableInvalidMessage informativeText:nil cancelButtonTitle:@"Close"
                                            otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
                                                
                                            } onCancel:^{
                                                
                                            }];
            }
            else{
                
                info.isEnable = !isEnable;
                [info saveToCoreData];
                [[AppDelegate shareInstance] saveContext:^(BOOL success) {
                    
                }];
            }
        }
    }
    
	
	
}


#pragma mark -
#pragma mark Compose Mail

//Begin section sending mail with .csv attacted
//------------------------------------------------------------------------------------------------------------------------------------------------

-(IBAction)showPicker;
{
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			//[self launchMailAppOnDevice];
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:kMailSubject];
	
	// Attach an image to the email
    NSData *myData = [NSData dataWithContentsOfFile:[Service dataFilePath]];
	[picker addAttachmentData:myData mimeType:@"text/csv" fileName:kCSVFileName];
	
	// Fill out the email body text
	NSString *emailBody = kMailContent;
	[picker setMessageBody:emailBody isHTML:NO];	
    [self presentViewController:picker animated:true completion:NULL];
}

//------------------------------------------------------------------------------------------------------------------------------------------------
// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	UILabel *message = [[UILabel alloc] init];
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message.text = @"Result: failed";
			break;
		default:
			message.text = @"Result: not sent";
			break;
	}
    [self dismissViewControllerAnimated:true completion:NULL];
}

//------------------------------------------------------------------------------------------------------------------------------------------------
// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = [NSString stringWithFormat:@"mailto:?&subject=%@", kMailSubject];
	NSString *body = [NSString stringWithFormat:@"&body=%@", kMailContent];
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
//------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark showFullScreen
-(IBAction) showFullScreen:(id) sender
{
	//BOOL statusBarHidden = [UIApplication sharedApplication].statusBarHidden;	
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) clearCSVfile:(id) sender{
	[Service deleteFilePath];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"メッセージ" 
														message:@"ログファイルを初期化しました" 
													   delegate:nil 
											  cancelButtonTitle:@"閉じる" 
											  otherButtonTitles:nil];
	[alertView show];
	
	
}

- (void)viewDidUnload {
    [self setTbView:nil];
    [super viewDidUnload];
}

#pragma --mark Fetched result delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    NSLog(@"will change");
    {
        [self.tbView beginUpdates];
    }
}
- (NSMutableArray *) objectsForSection:(NSInteger)section
{
    
    return nil;
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tbView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configCell:(SettingCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSLog(@"didChangeSection");
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tbView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tbView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
        {
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            break;
        }
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tbView endUpdates];
    
}
@end
