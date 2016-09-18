//
//  ResultViewController.h
//  LuckyPadSony
//
//  Created by dungnv9 on 13/12/2014.
//  Copyright (c) 2014 Applekikaku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (nonatomic, strong) NSMutableArray    *results;
@property (nonatomic, assign) NSInteger     resultIndex;
@property (nonatomic, assign) BOOL          isWin;

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;
@property (weak, nonatomic) IBOutlet UILabel *lbl6;
@property (weak, nonatomic) IBOutlet UILabel *lbl7;
@property (weak, nonatomic) IBOutlet UILabel *lbl8;

@end
