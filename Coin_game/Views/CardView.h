//
//  CardView.h
//  CardGame
//
//  Created by nguyen van dung on 11/23/13.
//  Copyright (c) 2013 dungnv9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView
{
    
}
@property (nonatomic, strong) UIImage   *cardImage;
@property (nonatomic, assign)  CGRect       placeRect;

-(void) flipCard;
- (void) setResultCard:(UIImage *)img;
- (void) setCardImage:(UIImage *)img;
- (void) shake :(CGRect)nrect;
- (void) stop;
@end
