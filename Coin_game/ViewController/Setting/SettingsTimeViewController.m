//
//  SettingsTimeViewController.m
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import "SettingsTimeViewController.h"
#import "TimeObject.h"

@interface SettingsTimeViewController ()<NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController        *fetchedResultController;
@end

@implementation SettingsTimeViewController
@synthesize editingObject;
@synthesize poverViewController;
@synthesize popController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSFetchedResultsController *)fetchedResultController
{
    if (!_fetchedResultController){
        NSFetchedResultsController *fetchController = [Time  MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:@"timeInterval" ascending:YES inContext:[NSManagedObjectContext MR_defaultContext]];
        _fetchedResultController = fetchController;
        _fetchedResultController.delegate = self;

    }
    return _fetchedResultController;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![self.fetchedResultController performFetch:NULL]){
        NSLog(@"fetch time info error");
    }
    // Do any additional setup after loading the view from its nib.
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    self.selectAllButton.selected = NO;
    [self.inputView initInputView];
    self.inputView.delegate = self;
    self.inputView.frame = self.view.bounds;
    
    self.settingView.layer.borderWidth = 1.0;
    self.settingView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.settingView.layer.cornerRadius = 6.0;
    self.settingView.layer.masksToBounds =YES;
    
    
    self.inputView.hidden = YES;
    [self selectAllTimeObjects:NO];
    [self.tbView reloadData];

}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    [self checkForCheckALlButton];
    NSInteger counter =[[self.fetchedResultController sections] count];
    return counter;
}

- (void) configCell:(SettingTimeCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell  prepareForReuse];
    cell.delegate = self;
    Time *__mo = [self.fetchedResultController objectAtIndexPath:indexPath];
    TimeObject *info = [[TimeObject alloc] initWithCoreData:__mo];
    cell.tag = indexPath.row;
    [cell displayContent:info];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *unikey = @"Timecell";
    SettingTimeCell *cell = (SettingTimeCell *)[tableView dequeueReusableCellWithIdentifier:unikey];
    if (!cell){
        NSArray *nibObjs = [[NSBundle mainBundle] loadNibNamed:@"SettingTimeCell" owner:self options:nil];
        if (nibObjs && nibObjs.count >0){
            cell = (SettingTimeCell *)[nibObjs objectAtIndex:0];
        }
    }
    
    [self configCell:cell atIndexPath:indexPath];
    if (indexPath.row %2 != 0){
        [cell.bgView setBackgroundColor:[UIColor colorWithRed:183.0/255.0
                                                        green:183.0/255.0
                                                         blue:183.0/255.0 alpha:1.0]];
    }
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Time *__mo = [self.fetchedResultController objectAtIndexPath:indexPath];
    TimeObject *info  = [[TimeObject alloc] initWithCoreData:__mo];
    info.isSelected = !info.isSelected;
    [info saveToDatabase];
    [[AppDelegate shareInstance] saveContext:^(BOOL success) {
        
    }];
}



- (IBAction)settingDateAcion:(id)sender {
}

- (IBAction)settingTimeAction:(id)sender {
}

- (IBAction)saveButtonAction:(id)sender {
    self.inputView.hidden = NO;
}

- (IBAction)deleteButtonAction:(id)sender {
    NSArray *arrs = [Time MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"isSelected = %d",1]];
    for (Time *__mo in arrs) {
        [[NSManagedObjectContext MR_defaultContext] deleteObject:__mo];
    }
    [[AppDelegate shareInstance] saveContext:^(BOOL success) {
        [self.tbView reloadData];
    }];
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectAllButtonAction:(id)sender {
    self.selectAllButton.selected = !self.selectAllButton.isSelected;
    [self selectAllTimeObjects:self.selectAllButton.isSelected];
}
- (void) selectAllTimeObjects:(BOOL)flag
{
    NSArray *arrs = [Time MR_findAll];
    for (Time *__mo in arrs) {
        __mo.isSelected = [NSNumber numberWithBool:flag];
    }
    [[AppDelegate shareInstance] saveContext:^(BOOL success) {
        
    }];
}
- (void) checkForCheckALlButton
{
    NSArray *arrs = [Time MR_findAll];
    int counter=  0;
    for (Time *__mo in arrs) {
        if ([__mo.isSelected boolValue]){
            counter +=1;
        }
    }
    if (counter == arrs.count && counter>0){
        self.selectAllButton.selected = YES;
    }else{
        self.selectAllButton.selected = NO;
    }
}
#pragma --mark setting time cell delegate
- (void) tappedOnChoiceButton:(SettingTimeCell *)cell isChoice:(BOOL) isChoice
{
    NSIndexPath *path = [self.tbView indexPathForCell:cell];
    Time *obj = [self.fetchedResultController objectAtIndexPath:path];
    TimeObject *info = [[TimeObject alloc]initWithCoreData:obj];
    if (info){
        info.isSelected = !info.isSelected;
        [info saveToDatabase];
        [[AppDelegate shareInstance] saveContext:^(BOOL success) {

        }];
    }
}

- (PopoverViewController *)poverViewController
{
    if (!poverViewController){
        poverViewController = [[PopoverViewController alloc] initWithNibName:@"PopoverViewController" bundle:nil];
        
        poverViewController.delegate = self;
    }
    return poverViewController;
}

- (UIPopoverController *)popController
{
    if (!popController){
        popController = [[UIPopoverController alloc] initWithContentViewController:self.poverViewController];
        CGSize size ;
        size.width = 291;
        size.height = 258;
        self.popController.popoverContentSize  =size;
    }
    
    popController.delegate = self;
    return popController;
}
- (void) tappedOnEditTimeColumn:(SettingTimeCell *)cell
{
    editingObject = cell.timeObject;
    self.poverViewController.mode = UIDatePickerModeTime;
    [self.popController presentPopoverFromRect:[self.tbView convertRect:cell.frame toView:self.view] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void) tappedOnEditDateColumn:(SettingTimeCell *)cell
{
    editingObject = cell.timeObject;
    self.poverViewController.mode = UIDatePickerModeDate;

    [self.popController presentPopoverFromRect:[self.tbView convertRect:cell.frame toView:self.view] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
#pragma --mark input delegate
- (void) didTapOnCloseButton:(InputView *)aview
{
    self.inputView.hidden =YES;
}
- (void) didTapOnCreateButton:(InputView *)aview newTimeInfo:(TimeObject *)info
{
    [self.tbView reloadData];
}
- (void) tappedOnDoneButton:(NSString *)result
{
    [self.popController dismissPopoverAnimated:YES];
    if (self.poverViewController.mode == UIDatePickerModeDate){
        self.editingObject.dateSetup = result;
    }else if (self.poverViewController.mode == UIDatePickerModeTime){
        self.editingObject.timeSetup = result;
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *str = [self.editingObject.dateSetup stringByAppendingFormat:@" %@",self.editingObject.timeSetup];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:str];
    self.editingObject.timeInterval  = [date timeIntervalSince1970];
    [self.editingObject saveToDatabase];
    [[AppDelegate shareInstance] saveContext:^(BOOL success) {
        
    }];
}

- (void) tappedOnCancelButton
{
    [self.popController dismissPopoverAnimated:YES];
}
- (void) dealloc
{
    self.fetchedResultController.delegate = nil;
    self.fetchedResultController = nil;
}
- (void)viewDidUnload {
    [self setSaveButton:nil];
    [self setDeleteButton:nil];
    [self setBackButton:nil];
    [self setTbView:nil];
    [self setInputView:nil];
    [self setSettingView:nil];
    [self setSelectAllButton:nil];
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
            [self configCell:(SettingTimeCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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
