//
//  Utils.h
//  LuckyPadSony
//
//  Created by dungnv9 on 5/12/14.
//  Copyright (c) 2014 Applekikaku. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NOTIFICATION_RELOAD_SETTING @"NOTIFICATION_RELOAD_SETTING"
#define NOTIFICATION_SETTING_VIEW_CLOSE @"NOTIFICATION_SETTING_VIEW_CLOSE"
#define KEY_SETTING_FOR_NO_REMAIN @"keysettingnoremain"

#define LAST_PLAY_IMG1 @"lastImg1"
#define LAST_PLAY_IMG2 @"lastImg2"
#define LAST_PLAY_IMG3 @"lastImg3"


#define KEY_EXPIRED_DATE @"expireddate"
#define DEFAULT_DATE_STRING @"2016-12-16"
#define EXPIRED_ALERT_STRING @"THIS APP HAS EXPIRED."
#define kErrorSettingMessage @"残り本数がありません。"

#define DB_NAME @"LuckyPadSony.sqlite"
#define  max_id 7
@interface Utils : NSObject
+ (void) writeDataToFile: (NSString *) contentToExpand;
+ (NSString *)generateUUID;
@end
