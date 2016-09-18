//
//  ReelView.h
//  LuckyPad_wagen
//
//  Created by dung nguyen van on 4/16/14.
//  Copyright (c) 2014 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"
@class ReelView;
@protocol ReelViewDelegate<NSObject>
- (void) didStop:(ReelView *)aview;
@end
@interface ReelView : UIView<ImageViewDelegate>
{
    
}
@property (nonatomic, strong) ImageView             *lastView;
@property (nonatomic, retain) UIScrollView          *scrollView;
@property (nonatomic, retain) NSMutableArray        *reels;
@property (nonatomic, assign) id <ReelViewDelegate> delegate;
@property (nonatomic, retain) UIImage               *stopImage;

- (id) initWithFrame:(CGRect)frame delegate:(id)adel firstimage:(UIImage *)img;
- (void) stopAll;
- (void) move;
- (void) stopWithImage:(UIImage *)img;
- (UIImage *) imageWithIndex:(int)index;
- (ImageView *)lastView;
- (ImageView *)firstView;
@end
