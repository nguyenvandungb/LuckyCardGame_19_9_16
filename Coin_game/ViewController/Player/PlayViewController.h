//
//  PlayViewController.h
//  Coin_Game
//
//  Created by Nguyen Van Dung on 3/21/16.
//  Copyright © 2016 FSIOSTeam. All rights reserved.
//

#import "AppViewController.h"
#import "CardView.h"

@interface PlayViewController : AppViewController
@property (nonatomic, assign) NSInteger playCount;
@property (weak, nonatomic) IBOutlet CardView *card1;
@property (weak, nonatomic) IBOutlet CardView *card2;
@property (weak, nonatomic) IBOutlet CardView *card3;
@property (strong, nonatomic) IBOutlet CardView *backCardView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLbl;

@end
