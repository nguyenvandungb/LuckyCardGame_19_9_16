//
//  Utils.m
//  LuckyPadSony
//
//  Created by dungnv9 on 5/12/14.
//  Copyright (c) 2014 Applekikaku. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(void) deleteLogFile
{
    NSFileManager *filemgr = [NSFileManager defaultManager];
    [filemgr removeItemAtPath:[Utils dataFilePath] error:NULL];
}
+ (UIImage *) rewardImageFromID:(int)aid
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"img%d.jpg",aid]];
}
+ (NSString *)generateUUID
{
    NSString *result = nil;
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid)
    {
        result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    
    return result;
}
+ (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"LogFile.csv"];
}
+ (void) writeDataToFile: (NSString *) contentToExpand
{
    //if file does not exist, create new file
    if (![[NSFileManager defaultManager] fileExistsAtPath:[Utils dataFilePath]]) {
        [[NSFileManager defaultManager] createFileAtPath: [Utils dataFilePath] contents:nil attributes:nil];
    }
    
    //say to handle where's the file fo write
    NSFileHandle *handle;
    handle = [NSFileHandle fileHandleForWritingAtPath: [Utils dataFilePath] ];
    NSFileHandle *fhRead = [NSFileHandle fileHandleForReadingAtPath:[Utils dataFilePath]];
    NSData *data = [fhRead readDataToEndOfFile];
    NSString *retStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    if([retStr length] != 0) {
        //add a slash to mark, for future use (get data and split to array)
        contentToExpand = [NSString stringWithFormat:@"\n%@",contentToExpand ];
    }
    //position handle cursor to the end of file
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    
    //write data to with the right encoding
    [handle writeData:[contentToExpand dataUsingEncoding:NSUTF8StringEncoding]];
    
    //close file after writing
    [handle closeFile];
    //[self readData];
}
@end
