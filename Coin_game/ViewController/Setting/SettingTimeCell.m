//
//  SettingTimeCell.m
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import "SettingTimeCell.h"

@implementation SettingTimeCell
@synthesize  orderIndexLabel;
@synthesize  setupDateButton;
@synthesize  setupTimeButton;
@synthesize  prizeNameLabel;
@synthesize  winDateLabel;
@synthesize  winTimeLabel;
@synthesize  choiceButton;
@synthesize delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) displayContent:(TimeObject *)tObject
{
    if (!tObject){
        return;
    }
    _timeObject = tObject;
    self.orderIndexLabel.text = [NSString stringWithFormat:@"%d",(int)[self tag] +1];
    [self.setupDateButton setTitle:tObject.dateSetup forState:UIControlStateNormal];
    [self.setupTimeButton setTitle:tObject.timeSetup forState:UIControlStateNormal];
    [self.winDateLabel setTitle:(tObject.dateWin.length >0)?tObject.dateWin:@"" forState:UIControlStateNormal];
    [self.winTimeLabel setTitle:(tObject.timeWin.length>0)?tObject.timeWin:@"" forState:UIControlStateNormal];
    
    Reward *__mo  = [Reward MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"rwID = %d",tObject.rewardID] inContext:[NSManagedObjectContext MR_defaultContext]];
    if (__mo){
        RewardInfo *ainfo = [[RewardInfo alloc] initWithCoreData:__mo];
        self.prizeNameLabel.text = ainfo.name;
    }
    
    
    [self.setupDateButton setEnabled:!tObject.isOut];
    [self.setupTimeButton setEnabled:!tObject.isOut];
    [self.choiceButton setSelected:tObject.isSelected];
}
- (void) prepareForReuse
{
     [self.choiceButton setSelected:NO];
}
- (IBAction)editDateAction:(id)sender {
    
    if (delegate && [delegate respondsToSelector:@selector(tappedOnEditDateColumn:)]){
        [delegate tappedOnEditDateColumn:self];
    }
}

- (IBAction)editTimeAction:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(tappedOnEditTimeColumn:)]){
        [delegate tappedOnEditTimeColumn:self];
    }
}
- (IBAction)choiceButtonAction:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(tappedOnChoiceButton:isChoice:)]){
        [delegate tappedOnChoiceButton:self isChoice:self.choiceButton.isSelected];
    }
}

@end
