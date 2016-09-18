//
//  PlayViewController.m
//  Coin_Game
//
//  Created by Nguyen Van Dung on 3/21/16.
//  Copyright © 2016 FSIOSTeam. All rights reserved.
//

#import "PlayViewController.h"
#import "ResultViewController.h"
#import "ResultViewController.h"
#import "CoreLuckyGame.h"
#import "Service.h"

@interface PlayViewController ()
{
    UIButton *animationButton;
    BOOL flag;
    AVAudioPlayer *Shellspinning;
    AVAudioPlayer *Shellstopped;
    BOOL flipped;
}
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) NSMutableArray *resultsInteracting;
@property (nonatomic, strong) RewardInfo *winReward;
@property (nonatomic, strong) NSMutableArray *listOfRewards;
@property (strong, nonatomic) NSMutableArray *listOfTimeObjects;
@property (strong, nonatomic) TimeObject *timeObject;
@property (strong, nonatomic) CardView *currentCard;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation PlayViewController

- (void)dealloc {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (NSMutableArray *)listOfRewards {
    if (!_listOfRewards) {
        _listOfRewards = [[NSMutableArray alloc] init];
    }
    if (_listOfRewards.count == 0) {
        NSArray *objs = [Reward MR_findAllSortedBy:@"rwID" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"isEnable = %d",1] inContext:[NSManagedObjectContext MR_defaultContext]];
        for (int i = 0; i < objs.count;i++) {
            Reward *__mo =  [objs objectAtIndex:i];
            RewardInfo *info = [[RewardInfo alloc] initWithCoreData:__mo];
            [_listOfRewards addObject:info];
        }
    }
    return _listOfRewards;
}


- (NSMutableArray *)listOfTimeObjects {
    if (!_listOfTimeObjects) {
        _listOfTimeObjects = [[NSMutableArray alloc] init];
    }
    
    if (_listOfTimeObjects.count ==0) {
        NSArray *objs = [Time MR_findAllSortedBy:@"timeInterval" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"isOut = %d",0] inContext:[NSManagedObjectContext MR_defaultContext]];
        for (int i = 0; i <objs.count; i++) {
            Time *__mo = [objs objectAtIndex:i];
            TimeObject *info = [[TimeObject alloc]initWithCoreData:__mo];
            NSLog(@"time :%f",info.timeInterval);
            [_listOfTimeObjects addObject:info];
        }
    }
    return _listOfTimeObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    _tap.numberOfTapsRequired = 3;
    [self.view addGestureRecognizer:_tap];
    flag = NO;
    [self loadMusicToApp];
    _winReward = nil;
    if (self.listOfRewards.count > 0) {
        [self calculateWin];
    }
    [self displayPlayCount];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self settingCard];
    [self reset];
    [self allowsTapOnCardView];
    [self resetForNextGame];
}

- (void) reset {
    [_card1 setCardImage:[UIImage imageNamed:@"cardbg1.png"]];
    [_card2 setCardImage:[UIImage imageNamed:@"cardbg2.png"]];
    [_card3 setCardImage:[UIImage imageNamed:@"cardbg3.png"]];
    [_card1 setResultCard: nil];
    [_card2 setResultCard: nil];
    [_card3 setResultCard: nil];
    _card1.userInteractionEnabled = true;
    _card2.userInteractionEnabled = true;
    _card3.userInteractionEnabled = true;
}

- (void)settingCard {
    _card1.backgroundColor = [UIColor clearColor];
    _card1.placeRect = _card1.frame;
    _card2.backgroundColor = [UIColor clearColor];
    _card2.placeRect = _card2.frame;
    _card3.backgroundColor = [UIColor clearColor];
    _card3.placeRect = _card3.frame;
}

- (void) allowsTapOnCardView
{
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(cardView1Tapped:)];
    [self.card1 addGestureRecognizer: tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(cardView2Tapped:)];
    [self.card2 addGestureRecognizer: tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(cardView3Tapped:)];
    [self.card3 addGestureRecognizer: tap3];
}

- (void) resetForNextGame {
    _backCardView = [[CardView alloc] initWithFrame:self.currentCard.bounds];
    _backCardView.backgroundColor = [UIColor clearColor];
    [_backCardView setCardImage:[self.currentCard cardImage]];
    [UIView transitionWithView:self.currentCard
                      duration: 0.7
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.currentCard.alpha = 0.5;
                        [self.currentCard addSubview:_backCardView];
                        
                    } completion:^(BOOL finished) {
                        flag = false;
                        [self reset];
                        self.winReward = nil;
                        [UIView animateWithDuration:0.2 animations:^{
                          //  self.backCardView.alpha = 0.0;
                            self.currentCard.alpha = 1.0;
                        } completion:^(BOOL finished) {
                            [self.backCardView removeFromSuperview];
                        }];
                    }];
}

-  (void) cardView1Tapped:(UITapGestureRecognizer *)tap {
    [self removeGestureRecognizer];
    [self showCardChoosed:self.card1];
}

-  (void) cardView2Tapped:(UITapGestureRecognizer *)tap {
    [self removeGestureRecognizer];
    [self showCardChoosed:self.card2];
}

-  (void) cardView3Tapped:(UITapGestureRecognizer *)tap {
    [self removeGestureRecognizer];
    [self showCardChoosed:self.card3];
}

- (void)displayPlayCount {
    self.playCountLbl.text = [NSString stringWithFormat:@"%ld",(long)self.playCount];
}

- (void) showCardChoosed:(CardView *)cardView
{
    [self.view removeGestureRecognizer:_tap];
    if (flag) {
        return;
    }
    flag = true;
    if (![self verify]) {
        return;
    }
    
    self.currentCard = cardView;
    AppDelegate *app = [AppDelegate shareInstance];
    if (app.gameType == TYPE_PLAY_ALL) {
        self.winReward = [self.resultsInteracting firstObject];
        [self.resultsInteracting removeAllObjects];
    } else {
        if (self.resultsInteracting.count > 0) {
            int rd = arc4random() % self.resultsInteracting.count;
            if (rd >= 0 && rd < self.resultsInteracting.count) {
                self.winReward = [self.resultsInteracting objectAtIndex:rd];
                [self.resultsInteracting removeObject:self.winReward];
            }
        }
    }
    if (!self.winReward) {
        return;
    }
    if (app.gameType == TYPE_PLAY_ALL) {
        self.playCount = 0;
    } else {
        self.playCount -= 1;
    }
    [self displayPlayCount];

    app.cannonFireSound.numberOfLoops =1;
    [app stopPlaySound:app.cannonFireSound];
    [app playSound:app.buttonSound];
    CGRect origin = cardView.placeRect;
    CGPoint center = cardView.center;
    __block CGRect r = origin ;
    r.size.height = 1.3*origin.size.height;
    r.size.width = 1;
    r.origin.y = center.y - (r.size.height/2);
    r.origin.x = center.x;
    
    [UIView animateWithDuration:0.7 animations:^{
        cardView.frame = r;
    } completion:^(BOOL finished) {
        
        NSString *imgName = [NSString stringWithFormat:@"card%ld.png", self.winReward.rwID + 1];
        [cardView setResultCard:[UIImage imageNamed:imgName]];
        r.size.width = 1.3*origin.size.width;
        r.origin.x = center.x - (r.size.width/2);
        r.origin.y = center.y - r.size.height/2;
        [UIView animateWithDuration:0.7 animations:^{
            cardView.frame =r;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.7 animations:^{
                cardView.frame = origin;
            } completion:^(BOOL finished) {
                //finish game
                AppDelegate *app = [AppDelegate shareInstance];
                float time = 0;
                if (self.winReward) {
                    RewardInfo *lastInfo = (RewardInfo *)[self.listOfRewards lastObject];
                    if (self.winReward.rwID != lastInfo.rwID){
                        time = app.finishWin.duration;
                        [app playSound:app.finishWin];
                    }else{
                        time = app.finishNotWin.duration;
                        [app playSound:app.finishNotWin];
                    }
                    
                }
                [self didFinishPlaySection];
            }];
        }];
    }];
}

- (void)didFinishPlaySection {
    [self saveGameResult];
    [_backBtn addGestureRecognizer:_tap];
    sleep(1);
    if (self.playCount > 0) {
        [self resetForNextGame];
    } else {
        [self gotoResultScreen];
    }
}

- (void)gotoResultScreen {
    ResultViewController *controller = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ResultViewController"];
    controller.resultIndex = _winReward.rwID;
    controller.results = self.results;
    controller.isWin = [self isWin];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) removeGestureRecognizer {
    _card1.userInteractionEnabled = false;
    _card2.userInteractionEnabled = false;
    _card3.userInteractionEnabled = false;
}

- (NSMutableArray *)results {
    if (!_results) {
        _results = [[NSMutableArray alloc] init];
    }
    return _results;
}

- (NSMutableArray *)resultsInteracting {
    if (!_resultsInteracting) {
        _resultsInteracting = [[NSMutableArray alloc] init];
    }
    return _resultsInteracting;
}

- (RewardInfo *) rewardInfoWithId:(int)aid {
    for (RewardInfo *info in self.listOfRewards) {
        if (info.rwID == aid) {
            return info;
        }
    }
    return nil;
}

- (void) playTimeWinningSettingIfNeed:(void(^)(BOOL isPlaytime))block {
    [self.results removeAllObjects];
    if ([self.listOfTimeObjects count] >0) {
        for (int i = 0; i < self.listOfTimeObjects.count; i++) {
            if (self.results.count >= self.playCount) {
                break;
            }
            
            TimeObject *tObject = [self.listOfTimeObjects objectAtIndex:i];
            if(tObject && !tObject.isOut) {
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
                [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
                [dateFormat setDateFormat:@"HH:mm:ss"];
                NSString *time = [dateFormat stringFromDate:[NSDate date]];
                [dateFormat setDateFormat:@"yyyy/MM/dd"];
                NSString *date = [dateFormat stringFromDate:[NSDate date]];
                [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                
                if (tObject.timeInterval < [[NSDate date] timeIntervalSince1970]) {
                    RewardInfo *info = [self rewardInfoWithId:tObject.rewardID];
                    tObject.dateWin = date;
                    tObject.timeWin = time;
                    tObject.isOut = YES;
                    self.timeObject = tObject;
                    info.isTimingObj = YES;
                    [self.results addObject:info];
                }
            }
        }
    }
    
    if (block){
        block(self.results.count > 0);
    }
}


- (void) loadMusicToApp {
    
    NSString *soundPath = [[NSBundle mainBundle]
                           pathForResource:@"drumroll" ofType:@"aif"];
    NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];
    Shellspinning =
    [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    NSString *soundPath1 = [[NSBundle mainBundle]
                            pathForResource:@"crush" ofType:@"aif"];
    NSURL *soundUR1L = [[NSURL alloc] initFileURLWithPath:soundPath1];
    Shellstopped =
    [[AVAudioPlayer alloc] initWithContentsOfURL:soundUR1L error:nil];
    
}

- (BOOL) isHasTimeObjectNeedToPlayOut {
    if ([self.listOfTimeObjects count] >0) {
        for (int i = 0; i < self.listOfTimeObjects.count; i++) {
            TimeObject *tObject = [self.listOfTimeObjects objectAtIndex:i];
            if(tObject && !tObject.isOut) {
                if (tObject.timeInterval < [[NSDate date] timeIntervalSince1970]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (void)removeRewardWithIds:(NSArray*)ids fromArraty:(NSMutableArray *)array {
    for (NSInteger i = array.count -1; i >= 0; i--) {
        RewardInfo *info = [array objectAtIndex:i];
        for (NSNumber *nb in ids) {
            if (info.rwID == nb.integerValue) {
                [array removeObject:info];
            }
        }
    }
}

- (void)resetPlayedTime:(NSMutableArray *)list {
    for (RewardInfo *temp in list) {
        temp.numberOfCurrentPlayed = 0;
    }
}

- (void) calculateWin {
    NSMutableArray *calculateingArrays = [[NSMutableArray alloc] initWithArray:self.listOfRewards];
    self.winReward = nil;
    [self.results removeAllObjects];
    [self.resultsInteracting removeAllObjects];
    if (self.results.count < self.playCount) {
        if (self.playCount >= 10) {
            for (RewardInfo *info in calculateingArrays) {
                if (info.rwID == 6 && info.remain > 0) {
                    info.remain -=1;
                    info.played +=1;
                    info.numberOfCurrentPlayed +=1;
                    [self.results addObject:[info copy]];
                    break;
                }
            }
        }
        [self resetPlayedTime:calculateingArrays];
        while (self.results.count < self.playCount) {
            RewardInfo *info = [[CoreLuckyGame shareInstance] calculateReward:calculateingArrays];
            if (info.rwID < 3) {
                [self removeRewardWithIds:@[@(0),@(1),@(2)] fromArraty:calculateingArrays];
            }
            [self.results addObject:[info copy]];
            [self resetPlayedTime:calculateingArrays];
        }
    }
    
    
    if (self.results.count > 0) {
        if (self.results.count > 1) {
            [self.results sortUsingComparator:^NSComparisonResult(RewardInfo* obj1, RewardInfo* obj2) {
                return obj1.rwID > obj2.rwID;
            }];
        }
        [self.resultsInteracting addObjectsFromArray:self.results];
    }
}

- (BOOL) isWin {
    RewardInfo *last = [self.listOfRewards lastObject];
    if (_winReward == last) {
        return NO;
    }
    return YES;
}

- (int) totalRemainWithOutLastPrize {
    NSArray *temp = [self.listOfRewards subarrayWithRange:NSMakeRange(0, self.listOfRewards.count -1)];
    int count = 0;
    for (RewardInfo *info in temp) {
        count += info.remain;
    }
    return count;
}

- (BOOL)verify {
    if ([[AppDelegate shareInstance] isExpired]) {
        [[FSAlert shareInstance] showAlertWithMessage:EXPIRED_ALERT_STRING informativeText:@"" cancelButtonTitle:@"Close" otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
            
        } onCancel:^{
            
        }];
        return NO;
    }
    
    if ([Service getEstablishBool]) {
        NSInteger counter = 0;
        for (RewardInfo *info in self.listOfRewards) {
            counter += info.remain;
        }
        if ((counter <=0 && [self totalRemainWithOutLastPrize]<=0) && ![self isHasTimeObjectNeedToPlayOut])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"アラート"
                                                            message:@"残り本数がなくなりました。"
                                                           delegate:self
                                                  cancelButtonTitle:@"閉じる"
                                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

- (void)saveGameResult {
    if ([AppDelegate shareInstance].gameType == TYPE_PLAY_ALL) {
        for (RewardInfo *info in self.results) {
            [info saveToCoreDataWithPlayedTime:info.numberOfCurrentPlayed];
            [self writeDataToCSVFile: info];
        }
    } else {
        if (self.winReward) {
            [self.winReward saveToCoreDataWithPlayedTime:self.winReward.numberOfCurrentPlayed];
            [self writeDataToCSVFile:self.winReward];
        }
    }
    [[AppDelegate shareInstance] saveContext:^(BOOL success) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *) spinImage:(int)lastIndex outIndex:(int *)outIndex{
    int rd = 0;
    rd = arc4random() % self.listOfRewards.count;
    RewardInfo *info = [self.listOfRewards objectAtIndex:rd];
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"img%d",(int)info.rwID + 1]];
    *outIndex = rd;
    return img;
}

-(void) writeDataToCSVFile:(RewardInfo *)info {
    if (info == nil) {
        return;
    }
    NSMutableString *str=  [NSMutableString string];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringDate = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"string date %@",stringDate);
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *stringTime = [dateFormatter stringFromDate:[NSDate date]];
    dateFormatter = nil;
    [str appendFormat:@"%@,%@,%ld,%d",stringDate,stringTime,info.rwID + 1,info.isTimingObj];
    [Utils writeDataToFile:[NSString stringWithFormat:@"%@",str]];
}


- (IBAction)backAction {
    [self.navigationController popToRootViewControllerAnimated:true];
}
@end
