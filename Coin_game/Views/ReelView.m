//
//  ReelView.m
//  LuckyPad_wagen
//
//  Created by dung nguyen van on 4/16/14.
//  Copyright (c) 2014 FSIOSTeam. All rights reserved.
//

#import "ReelView.h"
@interface ReelView()
{

}
@property (nonatomic, retain) NSTimer           *moveTimer;
@property (nonatomic, retain) NSMutableArray        *imagesList;
@end
@implementation ReelView
@synthesize scrollView = _scrollView;
@synthesize reels = _reels;
@synthesize delegate =_delegate;
@synthesize moveTimer = _moveTimer;
@synthesize stopImage = _stopImage;
@synthesize imagesList = _imagesList;




- (id) initWithFrame:(CGRect)frame delegate:(id)adel firstimage:(UIImage *)img
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _delegate = adel;
        
        CGRect r= frame;
        r.origin.x = 0;
        r.origin.y = 0;
        _scrollView = [[UIScrollView alloc] initWithFrame:r];
        _scrollView.backgroundColor = [UIColor clearColor];
        CGSize size = _scrollView.contentSize;
        size.height = 5*r.size.height;
        _scrollView.contentSize = size;
        _scrollView.contentOffset = CGPointMake(0,0);
        _scrollView.userInteractionEnabled = NO;
        if (!_imagesList){
            _imagesList = [[NSMutableArray alloc] init];
            [_imagesList addObject:[UIImage imageNamed:@"img1.jpg"]];
            [_imagesList addObject:[UIImage imageNamed:@"img2.jpg"]];
            [_imagesList addObject:[UIImage imageNamed:@"img3.jpg"]]; 
        }
        CGRect sub;
        sub.size = r.size;
        sub.origin.y = -size.height +r.size.height;
        sub.origin.x= 0;
        [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.reels removeAllObjects];
        for (int i = 0; i < 5; i++) {
            ImageView *imgView = [[ImageView alloc] initWithFrame:sub maxOrigin:0 minOrigin:(i==4)?(-size.height +20):(-size.height) del:self] ;
            imgView.image = img;
            imgView.numberOfPrize = _imagesList.count;
            sub.origin.y+= sub.size.height;
            [_scrollView addSubview:imgView];
            [self.reels addObject:imgView];
        }
        
        [self addSubview:_scrollView];
        [self lastView].image = img;
        
        
        
    }
    return self;
}
- (NSMutableArray *)imagesList
{
    if (!_imagesList){
        _imagesList = [[NSMutableArray alloc] init];
    }
    return _imagesList;
}
- (UIImage *) imageWithIndex:(int)index
{
    if (index <0 || index >self.imagesList.count || self.imagesList.count ==0){
        return nil;
    }
    return [self.imagesList objectAtIndex:index];
}

- (NSMutableArray *)reels
{
    if (!_reels){
        _reels = [[NSMutableArray alloc] init];
    }
    return _reels;
}
- (ImageView *)lastView
{
    if (self.reels.count ==0){
        return nil;
    }
    [self.reels sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        UIImageView *view1 = (UIImageView *)obj1;
        UIImageView *view2 = (UIImageView *)obj2;
        return view1.frame.origin.y > view2.frame.origin.y;
    }];
    return [self.reels lastObject];
}
- (ImageView *)firstView
{
    if (self.reels.count ==0){
        return nil;
    }

    [self.reels sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        UIImageView *view1 = (UIImageView *)obj1;
        UIImageView *view2 = (UIImageView *)obj2;
        return view1.frame.origin.y > view2.frame.origin.y;
    }];
    return [self.reels objectAtIndex:0];
}
- (void) move
{
    if (!_moveTimer){
        _moveTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(exeMove) userInfo:nil repeats:YES];
    }
    
}
- (void) stopWithImage:(UIImage *)img
{
    self.stopImage = img;
    [self.reels makeObjectsPerformSelector:@selector(stop)];
}

- (void) ImageViewDidStop:(ImageView *)aview
{
    [self stopAll];
    if (_delegate && [_delegate respondsToSelector:@selector(didStop:)]){
        [_delegate didStop:self];
    }
    
}
- (void) stopAll
{
    if (_moveTimer){
        if ([_moveTimer isValid]){
            [_moveTimer invalidate];
            _moveTimer = nil;
        }
    }
}
- (void)exeMove
{
    for (int i = 0; i < self.reels.count; i++) {
        ImageView *aview = [self.reels objectAtIndex:i];
        [aview move];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
