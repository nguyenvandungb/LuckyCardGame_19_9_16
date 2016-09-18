//
//  CardView.m
//  CardGame
//
//  Created by nguyen van dung on 11/23/13.
//  Copyright (c) 2013 dungnv9. All rights reserved.
//

#import "CardView.h"
@interface CardView()

@property (nonatomic, strong) UIImage   *resultCard;
@end
@implementation CardView
@synthesize placeRect = _placeRect;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) shake :(CGRect)nrect
{
    
}
- (void) stop
{

}

- (void) setResultCard:(UIImage *)img
{
    _resultCard = img;
    [self setNeedsDisplay];
    [self layoutSubviews];
}
- (void) setCardImage:(UIImage *)img
{
    _cardImage = img;
    [self setNeedsDisplay];
    [self layoutSubviews];
}
- (void) drawRect:(CGRect)rect
{
    UIImage *img = nil;
    if (_resultCard){
        img = _resultCard;
        
    }else if (_cardImage){
        img = _cardImage;
    }
    if (img){
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* fillColor = [UIColor colorWithRed: 0.295 green: 0 blue: 0.886 alpha: 1];
        UIColor* strokeColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
        UIColor* color2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0];
        
        //// Shadow Declarations
        UIColor* shadow = strokeColor;
        CGSize shadowOffset = CGSizeMake(5.1, 5.1);
        CGFloat shadowBlurRadius = 9.5;
        
        //// Rounded Rectangle Drawing
        
        CGRect r = CGRectMake(0, 0, self.frame.size.width -20, self.frame.size.height -20);
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: r cornerRadius: 4];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        [fillColor setFill];
        [img drawInRect:r];
        
        CGContextRestoreGState(context);
        
        [color2 setStroke];
        roundedRectanglePath.lineWidth = 1;
        [roundedRectanglePath stroke];
    }
    
}
@end
