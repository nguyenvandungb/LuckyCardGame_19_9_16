//
//  ResultViewController.m
//  LuckyPadSony
//
//  Created by dungnv9 on 13/12/2014.
//  Copyright (c) 2014 Applekikaku. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backAction:(id)sender;

@end

@implementation ResultViewController

- (void) dealloc {
     NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSInteger p1 = 0;
    NSInteger p2 = 0;
    NSInteger p3 = 0;
    NSInteger p4 = 0;
    NSInteger p5 = 0;
    NSInteger p6 = 0;
    NSInteger p7 = 0;
    NSInteger p8 = 0;
    for (RewardInfo *info in self.results) {
        if (info.rwID == 0) {
            p1 += 1;
        } else if (info.rwID == 1) {
            p2 += 1;
        } else if (info.rwID == 2) {
            p3 += 1;
        } else if (info.rwID == 3) {
            p4 += 1;
        } else if (info.rwID == 4) {
            p5 += 1;
        } else if (info.rwID == 5) {
            p6 += 1;
        } else if (info.rwID == 6) {
            p7 += 1;
        } else if (info.rwID == 7) {
            p8 += 1;
        }
    }
    _lbl1.text = [NSString stringWithFormat:@"%ld",p1];
    _lbl2.text = [NSString stringWithFormat:@"%ld",p2];
    _lbl3.text = [NSString stringWithFormat:@"%ld",p3];
    _lbl4.text = [NSString stringWithFormat:@"%ld",p4];
    _lbl5.text = [NSString stringWithFormat:@"%ld",p5];
    _lbl6.text = [NSString stringWithFormat:@"%ld",p6];
    _lbl7.text = [NSString stringWithFormat:@"%ld",p7];
    _lbl8.text = [NSString stringWithFormat:@"%ld",p8];
}

- (void)readyToBack {
    self.backBtn.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
