//
//  AppDelegate.h
//  LuckyPadSony
//
//  Created by dungnv9 on 5/12/14.
//  Copyright (c) 2014 Applekikaku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "RewardInfo.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LoginViewController *loginView;
    UINavigationController      *navigationController;
    
    
    AVAudioPlayer                            *cannonFireSound;
	AVAudioPlayer                            *stopSound;
	AVAudioPlayer                            *finishWin;
	AVAudioPlayer                            *finishNotWin;
    AVAudioPlayer                            *buttonSound;
    AVAudioPlayer                            *cardSound;
}

@property (nonatomic, retain) AVAudioPlayer                            *cannonFireSound;
@property (nonatomic, retain) AVAudioPlayer                            *stopSound;
@property (nonatomic, retain) AVAudioPlayer                            *finishWin;
@property (nonatomic, retain) AVAudioPlayer                            *finishNotWin;
@property (nonatomic, retain) AVAudioPlayer                            *buttonSound;
@property (nonatomic, retain) AVAudioPlayer                            *cardSound;
@property (nonatomic, retain) UINavigationController      *navigationController;
@property (nonatomic, retain) LoginViewController         *loginView;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) TYPE_GAME                   gameType;
- (void) setDateExpired:(NSString *)stringDate;
- (BOOL) isExpired;
- (void) stopPlaySound:(AVAudioPlayer *)_player;
- (void) playSound:(AVAudioPlayer *)_player;

+ (AppDelegate *) shareInstance;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (RewardInfo *)getRewardInfoByID:(int )aid from:(NSMutableArray *)array;
- (void)saveContext:(void(^)(BOOL success))block;
@end
