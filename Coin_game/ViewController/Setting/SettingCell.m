//
//  SettingCell.m
//  LuckyPad_Koala
//
//  Created by dung nguyen van on 3/12/14.
//  Copyright (c) 2014 FSIOSTeam. All rights reserved.
//

#import "SettingCell.h"
#import "RewardInfo.h"
@implementation SettingCell
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
+ (SettingCell *) newSettingCell
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil];
    if (arr && arr.count>0){
        return [arr objectAtIndex:0];
    }
    return nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) displayWithInfo:(RewardInfo *)obj
{
    self.backgroundColor = [UIColor clearColor];
    if (obj){
        self.info  = obj;
        self.name.text = obj.name;
        self.total.text =[NSString stringWithFormat:@"%ld",(long)obj.total];
        self.played.text =[NSString stringWithFormat:@"%ld",(long)obj.played];
        self.remain.text =[NSString stringWithFormat:@"%ld",(long)obj.remain];
        self.enableBtn.selected = !obj.isEnable;
    }
}
- (IBAction)showKeyboardAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(SettingCellWillUpdateValue:)])
    {
        [_delegate SettingCellWillUpdateValue:self];
    }
}

- (IBAction)enableOrDisableAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(SettingCellEnableDisableBtnPressed:)]){
        [_delegate SettingCellEnableDisableBtnPressed:self];
    }
}
@end
