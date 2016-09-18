    //
//  InputDataViewController.m
//  DemoCasino


#import "InputDataViewController.h"
#import "Service.h"
#import "RewardInfo.h"

@implementation InputDataViewController
@synthesize lable;
//@synthesize imageInputName,label2;
@synthesize hazureName;



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation== UIInterfaceOrientationLandscapeRight))
    {
        return YES;
    }
    return NO;
    
}
//------------------------------------------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------------------------------------------
- (void) loadSettingViewController: (RewardInfo *)info{
	
	valueObj =info.rwID;
    lable.text = [NSString stringWithFormat:@"%ld",(long)info.total];
    hazureName.text = info.name;
}

//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) exitInputData
{
    Reward *__mo = [Reward MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"rwID = %d",valueObj] inContext:[NSManagedObjectContext MR_defaultContext]];
    if (__mo){
        RewardInfo *info = [[RewardInfo alloc] initWithCoreData:__mo];
        if (info)
        {
            info.total = lable.text.integerValue;
            info.remain = info.total - info.played;
            info.name = hazureName.text;
            [info saveToCoreData];
            [[AppDelegate shareInstance] saveContext:^(BOOL success) {
                [self removeFromSuperview];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_SETTING object:nil];
            }];
        }
        
        
        
    }
    
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) clearLable{
	[lable setText:@""];
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_1{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@1",lable.text]];
	}	
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_2{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@2",lable.text]];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_3{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@3",lable.text]];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_4{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@4",lable.text]];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_5{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@5",lable.text]];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_6{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@6",lable.text]];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_7{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@7",lable.text]];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_8{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@8",lable.text]];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_9{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@9",lable.text]];
	}
}
//------------------------------------------------------------------------------------------------------------------------------------------------
-(IBAction) addNumberlabler_0{
	if([lable.text length] < 11) {
		[lable setText:[NSString stringWithFormat:@"%@0",lable.text]];
	}
}

//--------------------------------------------------------------------------------------------------
#pragma --
#pragma UITextField delegate //等賞名の文字数制限
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 11) ? NO : YES;
}

@end
