//
//  ImageView.h
//  LuckyPad_wagen
//
//  Created by dung nguyen van on 4/16/14.
//  Copyright (c) 2014 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageView;
@protocol ImageViewDelegate <NSObject>
- (void) ImageViewDidStop:(ImageView *)aview;
@end
@interface ImageView : UIImageView
{
    
}
@property (nonatomic, assign)  BOOL     isChangedImage;
@property (nonatomic, assign)  id <ImageViewDelegate>  delegate;
@property (nonatomic, assign)  NSInteger  numberOfPrize;
- (id) initWithFrame:(CGRect)frame maxOrigin:(CGFloat) max minOrigin:(CGFloat)min del:(id)adel;
- (void) move;
- (void) stop;
@end
