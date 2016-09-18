//
//  Service.h
//  GameCasino
//


#import <Foundation/Foundation.h>

#define kNumberOfReward 11

#define kImageWin @"ImageWin"
#define kImageNotWin @"ImageNotWin"

#define kWin @"Win"
#define kNotWin @"NotWin"

#define kEnabled @"Enabled"
#define kAlreadyFirstEnabledAll @"AlreadyFirstEnabledAllRewards"
#define kEstablishBool @"EstablishBool"

#define kCSVFileName @"LogFile.csv"

#define kArrayHazureName @"ArrayHazureName"

#define kPassCode   @"passcode"
#define kDefaultPass @"0000" //0000
#define kBlankPasscodeMessage @"パスコードを入力して下さい"
#define kWrongPasscodeMessage @"パスコードが一致しません"

#define kPassCodeNotMatch @"パスコードが一致しません"
#define kPasscodeValidate @"4桁のパスコードを入力してください"

@interface Service : NSObject {
	NSMutableArray* arListEnableStatus ;
}
@property(nonatomic, retain) NSMutableArray* arListEnableStatus ;


+ (void) saveToEstablishBool: (BOOL) _value;
+ (BOOL) getEstablishBool;
+ (BOOL) getHazureBool;

+ (BOOL) getEnabledForType:(NSInteger) rewardType;
+ (NSMutableArray *) getListEnableRewards;

+ (BOOL) checkIfReachMinNumOfEnableRewards: (NSInteger) minNumOfEnableRewards;

+ (BOOL) checkExitsHazureForWin;

+ (BOOL) checkImageWinLeft: (BOOL) isEstablish;

+ (NSString *)dataFilePath;
+ (void) deleteFilePath;
+ (void) writeDataToFile: (NSString *) contentToExpand;
+ (NSString *) readData;


#pragma --
#pragma mark load/change Passcode
+ (NSString *) loadPasscode;
+ (void) changePasscode: (NSString *) _passcode;


@end
