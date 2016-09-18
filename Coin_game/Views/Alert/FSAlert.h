#import <Foundation/Foundation.h>

typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)();

@interface FSAlert: NSObject
{
    DismissBlock _dismissBlock;
    CancelBlock _cancelBlock;
}

+ (FSAlert *) shareInstance;
- (void)    showAlertWithMessage:(NSString*) message
								informativeText:(NSString*) text
							 cancelButtonTitle:(NSString*) cancelButtonTitle
							 otherButtonTitles:(NSString*) otherButtons
										onDismiss:(DismissBlock) dismissed
										 onCancel:(CancelBlock) cancelled;

@end