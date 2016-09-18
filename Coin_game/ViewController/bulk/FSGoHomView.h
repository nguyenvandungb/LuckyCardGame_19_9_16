//
//  FSGoHomView.h
//  roulette
//
//  Created by FSIOSTeam on 11/14/12.
//  Copyright (c) 2012 FSIOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSGoHomView;
@protocol FSHomeViewDelegate <NSObject>

- (void) didDoubleTapOnGoHomeView:(FSGoHomView *)_view;

@end
@interface FSGoHomView : UIView
{
    __unsafe_unretained id <FSHomeViewDelegate>     _parent;
}
@property (nonatomic, unsafe_unretained) id <FSHomeViewDelegate>  parent;
- (id) initWithParentViewController :(id<FSHomeViewDelegate>)_aparent;
- (void) show;
@end
