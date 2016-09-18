//
//  InputCell.h
//  luckyPad_25Prize
//
//  Created by nguyen van dung on 9/10/13.
//  Copyright (c) 2013 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InputCell;
@protocol InputCellDelegate<NSObject>
- (void) didTapOnInputCell:(InputCell *)acell;
@end


@interface InputCell : UITableViewCell

{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@property (assign, nonatomic) id <InputCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *Titlelabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UIButton *overlayButton;
- (IBAction)overlayButtonAction:(id)sender;

@end
