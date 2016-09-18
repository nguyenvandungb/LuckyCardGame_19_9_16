//
//  FSSTDNumberKeyboardViewController.m
//  roulette
//
//  Created by FSIOSTeam on 11/5/12.
//  Copyright (c) 2012 FSIOSTeam. All rights reserved.
//

#import "FSSTDNumberKeyboardViewController.h"

@interface FSSTDNumberKeyboardViewController ()
- (void) deleteDigital:(NSInteger)_digital;
- (NSString *) stringFromArray:(NSMutableArray *)_array;
@end

@implementation FSSTDNumberKeyboardViewController
@synthesize keyboardDelegate = _keyboardDelegate;
@synthesize digitals = _digitals;

- (void) dealloc
{
    self.digitals = nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.digitals)
    {
        [self.digitals removeAllObjects];   
    }
}
- (void) viewDidAppear:(BOOL)animated
{
    if (self.digitals)
    {
        [self.digitals removeAllObjects];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setBtnNum1:nil];
    [self setBtnNum2:nil];
    [self setBtnNum3:nil];
    [self setBtnNum4:nil];
    [self setBtnNum5:nil];
    [self setBtnNum6:nil];
    [self setBtnNum7:nil];
    [self setBtnNum8:nil];
    [self setBtnNum9:nil];
    [self setBtnNum0:nil];
    [self setBtnReturn:nil];
    [super viewDidUnload];
}
- (void) deleteDigital:(NSInteger)_digital
{
    if ((!_digitals.count)>0)
    {
        return;
    }
    
    [_digitals removeObjectAtIndex:_digitals.count-1];
}

- (NSString *) stringFromArray:(NSMutableArray *)_array
{
    NSMutableString *rs = [NSMutableString string];
    if (_array.count ==0)
    {
        [rs appendString:@"0"];
    }
    
    for (int i = 0 ; i < _digitals.count; i++)
    {
        NSNumber *num = [_digitals objectAtIndex:i];
        [rs appendFormat:@"%ld",(long)[num  integerValue]];
    }
    return  [NSString stringWithFormat:@"%@",(rs)?rs:@"0"];
}
- (IBAction)action:(id)sender
{
    if (!_digitals)
    {
        _digitals= [[NSMutableArray alloc] init];
    }
    
    NSInteger tag = [(UIButton*)sender tag];
    switch (tag) {
        case 10://delete
        {
            [self deleteDigital:tag];
            [self.keyboardDelegate didDeleteNumber:[self stringFromArray:self.digitals]];
            break;
        }
        case 11://return
        {
            [self.keyboardDelegate didReturnPressed:self];
            break;
        }
        default:
        {
            if (_digitals.count==0)
            {
                if (tag==0)
                {
                    return;
                }
            }
            
            if (_digitals.count == 4)
            {
                return;
            }
            [_digitals addObject:[NSNumber numberWithInteger:tag]];
            [self.keyboardDelegate didPressedNumber:[self stringFromArray:self.digitals]];
            break;
        }
    }
}
@end
