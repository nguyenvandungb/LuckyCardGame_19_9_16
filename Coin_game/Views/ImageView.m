//
//  ImageView.m
//  LuckyPad_wagen
//
//  Created by dung nguyen van on 4/16/14.
//  Copyright (c) 2014 FSIOSTeam. All rights reserved.
//
#import "ReelView.h"
#import "ImageView.h"
@interface ImageView()
{
    int         counter;
    int         lastIndex;
}
@property (nonatomic, assign) CGFloat max;
@property (nonatomic, assign) CGFloat min;
@property (nonatomic, assign) BOOL    willStop;
@property (nonatomic, assign) BOOL    needCheck;
@property (nonatomic, assign) BOOL    stopped;
@end

@implementation ImageView
@synthesize max = _max;
@synthesize min = _min;
@synthesize needCheck = _needCheck;
@synthesize willStop =_willStop;
@synthesize delegate =_delegate;
- (id) initWithFrame:(CGRect)frame maxOrigin:(CGFloat) mx minOrigin:(CGFloat)mn del:(id)adel
{
    self = [super initWithFrame:frame];
    if (self) {
        _delegate = adel;
        _max = mx;
        _min = mn;
        counter = 0;
        lastIndex = 0;
    }
    return self;
}

- (void) move
{
    ReelView *parent = (ReelView *)self.delegate;
    __block CGRect r= self.frame;
    if (!_stopped){
        r.origin.y += 20;
        self.frame = r;
    }else{
        
    }
    
    if (_needCheck){
        if (r.origin.y >= _max -30){
            if (!_stopped){
                _stopped = YES;
                r.origin.y = _max;
                [UIView animateWithDuration:.1 animations:^{
                    self.frame = r;
                } completion:^(BOOL finished) {
                    if (_delegate && [_delegate respondsToSelector:@selector(ImageViewDidStop:)]){
                        
                        [_delegate ImageViewDidStop:self];
                    }
                }];
            }
        }
        return;
    }
    if (r.origin.y >= _max + r.size.height ){;
        if (!_willStop ) {
            r.origin.y = [parent firstView].frame.origin.y-r.size.height;
            self.frame = r;
        }else{
            _stopped = YES;
        }
    }
    
    if (!_willStop){
        if(r.origin.y < _max - r.size.height){
            int rd = arc4random()% _numberOfPrize;
            if (rd == lastIndex){
                counter +=1;
                lastIndex   = rd;
            }else{
                lastIndex = rd;
                counter = 0;
            }
            if (counter >=2){
                rd = arc4random()% _numberOfPrize;
            }
            if (_delegate && [_delegate isKindOfClass:[ReelView class]]){
                
                self.image = [(ReelView *)_delegate imageWithIndex:rd];
            }
        }
    }
}
- (void) stop
{
    _willStop = YES;
    ReelView *parent = (ReelView *)self.delegate;
    ImageView *first = [parent firstView];
    if (self == first){
        _needCheck  = YES;
        self.image = parent.stopImage;
    }
}
@end
