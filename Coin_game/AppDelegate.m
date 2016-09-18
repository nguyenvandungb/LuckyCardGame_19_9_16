//
//  AppDelegate.m
//  LuckyPadSony
//
//  Created by dungnv9 on 5/12/14.
//  Copyright (c) 2014 Applekikaku. All rights reserved.
//

#import "AppDelegate.h"
#import "NSPersistentStore+MagicalRecord.h"
#import "MagicalRecord+Setup.h"

@implementation AppDelegate
@synthesize navigationController;
@synthesize loginView;

@synthesize cannonFireSound;
@synthesize stopSound;
@synthesize finishWin;
@synthesize finishNotWin;
@synthesize buttonSound;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- (void) dealloc
{
    self.cannonFireSound = nil;
    self.stopSound = nil;self.finishNotWin = nil;
    self.finishWin = nil;
    self.buttonSound = nil;
}

- (void) stopPlaySound:(AVAudioPlayer *)_player
{
    if (_player.isPlaying)
    {
        [_player playAtTime:_player.duration];
        
        [_player stop];
    }
}
- (void) playSound:(AVAudioPlayer *)_player
{
    
    [self stopPlaySound:_player];
    _player.currentTime = 0;
    [_player play];
}



- (void) loadMusicToApp
{
    @autoreleasepool {
        // get the path for the cannon firing sound
        NSString *soundPath = [[NSBundle mainBundle]
                               pathForResource:@"music" ofType:@"wav"];
        
        NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];
        
        cannonFireSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
        
        NSString *soundPath1 = [[NSBundle mainBundle]
                                pathForResource:@"crush" ofType:@"aif"];
        
        // create a URL from the path
        NSURL *soundUR1L = [[NSURL alloc] initFileURLWithPath:soundPath1];
        
        
        stopSound =	[[AVAudioPlayer alloc] initWithContentsOfURL:soundUR1L error:nil];
        //------------------------------------------------------------------------------------------
        NSString *soundPath2 = [[NSBundle mainBundle]
                                pathForResource:@"atari" ofType:@"aif"];
        
        // create a URL from the path
        NSURL *soundUR2L = [[NSURL alloc] initFileURLWithPath:soundPath2];
        
        
        finishWin =[[AVAudioPlayer alloc] initWithContentsOfURL:soundUR2L error:nil];
        soundUR2L = nil;
        //------------------------------------------------------------------------------------------
        NSString *soundPath3 = [[NSBundle mainBundle]
                                pathForResource:@"hazure" ofType:@"aif"];
        
        // create a URL from the path
        NSURL *soundUR3L = [[NSURL alloc] initFileURLWithPath:soundPath3];
        
        
        finishNotWin =[[AVAudioPlayer alloc] initWithContentsOfURL:soundUR3L error:nil];
       soundUR3L =nil;
        //------------------------------------------------------------------------------------------
        NSString *soundPath4 = [[NSBundle mainBundle]
                                pathForResource:@"popi" ofType:@"aif"];
        
        // create a URL from the path
        NSURL *soundUR4L = [[NSURL alloc] initFileURLWithPath:soundPath4];
        buttonSound =[[AVAudioPlayer alloc] initWithContentsOfURL:soundUR4L error:nil];
        
        // create a URL from the path
        NSString *soundPath5 = [[NSBundle mainBundle]
                                pathForResource:@"card" ofType:@"aif"];
        NSURL *soundUR5L = [[NSURL alloc] initFileURLWithPath:soundPath5];
        cardSound =[[AVAudioPlayer alloc] initWithContentsOfURL:soundUR5L error:nil];
        
        [self.buttonSound prepareToPlay]; self.buttonSound.currentTime = 0.0; self.buttonSound.volume = 1.0;
        [self.finishNotWin prepareToPlay]; self.finishNotWin.currentTime = 0.0; self.finishNotWin.volume = 1.0;
        [self.finishWin prepareToPlay]; self.finishWin.currentTime = 0.0; self.finishWin.volume = 1.0;
        [self.stopSound prepareToPlay]; self.stopSound.currentTime = 0.0; self.stopSound.volume = 1.0;
        [self.cannonFireSound prepareToPlay]; self.cannonFireSound.currentTime = 0.0; self.cannonFireSound.volume = 0.6;
        self.cannonFireSound.numberOfLoops =-1;
        
        
    }
    
    
    
}
- (RewardInfo *)getRewardInfoByID:(int )aid from:(NSMutableArray *)array
{
    for (int i = 0; i < array.count; i++) {
        RewardInfo *ainfo = [array objectAtIndex:i];
        if (ainfo.rwID == aid){
            return ainfo;
        }
    }
    return nil;
}
/*
 Created by: dungnv
 Created date: 2012-12-23
 Input: stringDate with Format : YYYY-MM-Dd (13-2-2)
 
 
 */
- (void) setDateExpired:(NSString *)stringDate
{
    if (stringDate==nil)
    {
        stringDate = DEFAULT_DATE_STRING;
    }
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [df dateFromString:stringDate];
    if (date)
    {
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:KEY_EXPIRED_DATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSLog(@" => set expired date: %@",date.description);
}
- (BOOL) isExpired
{
    NSDate *today = [NSDate date];
    double tinterval = [today timeIntervalSince1970];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *stdate = [formatter dateFromString:DEFAULT_DATE_STRING];
    double sttimeinterval = [stdate timeIntervalSince1970];
    if (tinterval > sttimeinterval){
        return YES;
    }
    
    return NO;
}

static NSString * const kCoreData = @"Lucky.xcdatamodeld";

- (void) copyDefaultStoreIfNecessary:(NSString*)coreDataFileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:coreDataFileName];
    NSLog(@"%@",storeURL.absoluteString);
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:[storeURL path]])
    {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:[kCoreData stringByDeletingPathExtension] ofType:[kCoreData pathExtension]];
        
        if (defaultStorePath)
        {
            NSError *error;
            BOOL success = [fileManager copyItemAtPath:defaultStorePath toPath:[storeURL path] error:&error];
            if (!success)
            {
                NSLog(@"Failed to install default recipe store");
            }
        }
    }
}



- (void) setupCoreData
{
    NSString* coreDataFileName = kCoreData;
    [self copyDefaultStoreIfNecessary:coreDataFileName];
    [MagicalRecord setupCoreDataStackWithStoreNamed:coreDataFileName];
    
    NSArray *titles = @[
                        @"A賞",
                        @"B賞",
                        @"C賞",
                        @"D賞",
                        @"E賞",
                        @"F賞",
                        @"G賞",
                        @"H賞"
                        ];
    NSArray *arr = [Reward MR_findAll];
    if (!arr || arr.count ==0){
        for (int i = 0; i < titles.count; i++) {
            RewardInfo *info = [[RewardInfo alloc] init];
            info.name = [titles objectAtIndex:i];
            info.total = 0;
            info.rwID = i;
            info.played = 0;
            info.remain = 0;
            info.isEnable = YES;
            [info saveToCoreData];
        }
        [self saveContext:^(BOOL success) {
            
        }];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupCoreData];
    NSLog(@"==>document :%@",[self applicationDocumentsDirectory]);
    [NSThread detachNewThreadSelector:@selector(loadMusicToApp) toTarget:self withObject:nil];
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for  after application launch.
    loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    navigationController = [[UINavigationController alloc] initWithRootViewController:loginView];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    [self.window becomeKeyWindow];
    return YES;
}
+ (AppDelegate *) shareInstance
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext:NULL];
}

- (void)saveContext:(void(^)(BOOL success))block
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (block){
            block(success);
        }
    }];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LuckyPadSony" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LuckyPadSony.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
