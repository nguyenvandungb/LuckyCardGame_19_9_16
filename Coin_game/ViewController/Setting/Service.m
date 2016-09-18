//
//  Service.m
//  GameCasino


#import "Service.h"
#import "RewardInfo.h"

@implementation Service
@synthesize arListEnableStatus;


//------------------------------------------------------------------------------------------------------------------------------------------------
+ (void) saveToEstablishBool: (BOOL) _value{
	[[NSUserDefaults standardUserDefaults] setBool:_value forKey:kEstablishBool];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL) getEstablishBool{
	return [[NSUserDefaults standardUserDefaults] boolForKey:kEstablishBool];

}
+ (BOOL) getHazureBool{
	return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@%i",kEnabled,kNumberOfReward-1]];
}




+ (void) saveToDefaultWin{
	for (int i=0; i<kNumberOfReward; i++) {
		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:[NSString stringWithFormat:@"%@%i",kWin,i]];
    //[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:[NSString stringWithFormat:@"%@%i",kImageWin,i]];    
	}
	[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kNotWin];	
}




//------------------------------------------------------------------------------------------------------------------------------------------------
+ (BOOL) checkExitsHazureForWin{
    
	NSMutableArray *listEnableRewards = [self getListEnableRewards];
	
	NSInteger countEnable =0;
	for (int i=0; i<listEnableRewards.count; i++)
    {
        RewardInfo *info = [listEnableRewards objectAtIndex:i];
		if (info.isEnable == 1)
        {
			countEnable++;
		}
	}
	if (countEnable==1) return YES;
	return NO;
	
}


// added by DatNT
// handle csv file
//------------------------------------------------------------------------------------------------------------------------------------------------
+ (NSString *)dataFilePath;
{ 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    return [documentsDirectory stringByAppendingPathComponent:kCSVFileName];
}	
+ (void) deleteFilePath{
	NSFileManager *filemgr = [NSFileManager defaultManager];
	[filemgr removeItemAtPath:[Service dataFilePath] error:NULL];
	
}
//test ok
+ (void) writeDataToFile: (NSString *) contentToExpand;
{
	//if file does not exist, create new file
	if (![[NSFileManager defaultManager] fileExistsAtPath:[Service dataFilePath]]) {
		[[NSFileManager defaultManager] createFileAtPath: [Service dataFilePath] contents:nil attributes:nil];	
	}
	
	//say to handle where's the file fo write
	NSFileHandle *handle;
	handle = [NSFileHandle fileHandleForWritingAtPath: [Service dataFilePath] ]; 
	NSFileHandle *fhRead = [NSFileHandle fileHandleForReadingAtPath:[Service dataFilePath]];	
	NSData *data = [fhRead readDataToEndOfFile];
	NSString *retStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];	
	if([retStr length] != 0) {
		//add a slash to mark, for future use (get data and split to array)
		contentToExpand = [NSString stringWithFormat:@"\n%@",contentToExpand ];
	}
	NSLog(@"%lu",(unsigned long)[data length]);
    retStr  =nil;
	//position handle cursor to the end of file
	[handle truncateFileAtOffset:[handle seekToEndOfFile]]; 
	
	//write data to with the right encoding
	[handle writeData:[contentToExpand dataUsingEncoding:NSUTF8StringEncoding]];   	
    
	//close file after writing
	[handle closeFile];	
	//[self readData];
}
//------------------------------------------------------------------------------------------------------------------------------------------------
//test ok
+ (NSString *) readData;
{
	NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:[Service dataFilePath]];
	if(fh == nil)
        return nil;
	else
	{
        NSData *data = [fh readDataToEndOfFile];
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
		//NSLog(retStr);
        return retStr;
	}
	
}


#pragma --
#pragma mark load/change Passcode
+ (NSString *) loadPasscode{
    NSString *passCode = [[NSUserDefaults standardUserDefaults] objectForKey:kPassCode];
    if (passCode == nil) {
        passCode = kDefaultPass;
    }
    return passCode;
}
//--------------------------------------------------------------------------------------------------
+ (void) changePasscode: (NSString *) _passcode{
    [[NSUserDefaults standardUserDefaults] setObject:_passcode forKey:kPassCode];
}
//--------------------------------------------------------------------------------------------------

@end
