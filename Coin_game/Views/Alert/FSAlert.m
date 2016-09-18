#import "FSAlert.h"

static FSAlert *_this = nil;


@implementation FSAlert
+ (FSAlert *) shareInstance
{
    if (!_this){
        _this = [[FSAlert alloc] init];
    }
    return _this;
}
- (void)showAlertWithMessage:(NSString*) message
                          informativeText:(NSString*) text
                        cancelButtonTitle:(NSString*) cancelButtonTitle
                        otherButtonTitles:(NSString*) otherButtons
                                onDismiss:(DismissBlock) dismissed
                                 onCancel:(CancelBlock) cancelled {
	
	_cancelBlock  = [cancelled copy];
	_dismissBlock  = [dismissed copy];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:otherButtons,nil] ;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // cancel button is last button added
	if( buttonIndex == alertView.cancelButtonIndex)
	{
		_cancelBlock();
	}
	else
	{
		_dismissBlock(buttonIndex);
	}
}


@end