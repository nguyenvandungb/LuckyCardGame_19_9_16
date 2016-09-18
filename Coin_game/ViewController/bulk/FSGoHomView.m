//
//  FSGoHomView.m
//  roulette
//
//  Created by FSIOSTeam on 11/14/12.
//  Copyright (c) 2012 FSIOSTeam. All rights reserved.
//

#import "FSGoHomView.h"

@implementation FSGoHomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (id) initWithParentViewController :(id<FSHomeViewDelegate>)_aparent
{
    UIViewController *controller = (UIViewController *)_aparent;
    CGRect mRect = controller.view.frame;
    CGRect arec;
    arec.size.width =200;
    arec.size.height = 90;
    arec.origin.y = 0;
    arec.origin.x = mRect.size.width - arec.size.width;
    self = [super initWithFrame:arec];
    if (self)
    {
        self.parent = _aparent;
        UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(handleDoubeleTap:)];
        tapGesture.numberOfTapsRequired = 2;
        tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}


- (void ) handleDoubeleTap:(UIGestureRecognizer *)recognizer
{
    [self.parent  didDoubleTapOnGoHomeView:self];
}
- (void) show
{
    UIViewController *controller  = (UIViewController *)self.parent;
    [controller.view addSubview: self];
}


@end
