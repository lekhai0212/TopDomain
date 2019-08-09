//
//  WriteLogsUtils.m
//  iMomeet
//
//  Created by lam quang quan on 11/12/18.
//  Copyright © 2018 Softfoundry. All rights reserved.
//

#import "WriteLogsUtils.h"

@implementation WriteLogsUtils

+ (BOOL)createLogFileWithName: (NSString *)filePathName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:filePathName];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
            return NO;
        }else{
            return YES;
        }
    }
    //  This file is exists
    return NO;
}

+ (NSString *)makeFilePathWithFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *url = [paths objectAtIndex:0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", url, fileName];
    return filePath;
}

+ (NSString *)getLogContentIfExistsFromFile: (NSString *)filePath isFullPath: (BOOL)isFullPath{
    if (!isFullPath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *url = [paths objectAtIndex:0];
        filePath = [NSString stringWithFormat:@"%@/%@", url, filePath];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
        NSString *contents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        return contents;
    }
    return @"";
}

//  [Khai le - 16/11/2018]: Clear logs file
+ (void)clearLogFilesAfterExpireTime: (long)expireTime
{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES) objectAtIndex:0];
    NSString *pathDir = [documentDir stringByAppendingPathComponent: logsFolderName];
    NSArray *pFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathDir error:NULL];
    for (int count = 0; count < (int)[pFiles count]; count++)
    {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", pathDir, [pFiles objectAtIndex: count]];
        NSDictionary* fileAttribs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        NSDate *createdDate = [fileAttribs objectForKey:NSFileCreationDate]; //or NSFileModificationDate
        if (createdDate != nil) {
            NSTimeInterval secondsBetween = [[NSDate date] timeIntervalSinceDate:createdDate];
            if (secondsBetween >= expireTime) {
                [self removeFileWithPath: filePath];
                NSLog(@"Expire");
            }
        }
    }
}

+ (void)removeFileWithPath: (NSString *)path {
    // remove file if exist
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath: path];
    if (fileExists) {
        BOOL success = [fileManager removeItemAtPath:path error:&error];
        if (success) {
            NSLog(@"Deleted file of event");
        }
    }
}

+ (NSArray *)getAllFilesInDirectory: (NSString *)subPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent: subPath];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    return directoryContent;
}

+ (void)writeForGoToScreen: (NSString *)screen {
    NSString *content = [NSString stringWithFormat:@"\n\n>>>>>>>>>>>>>>> GO TO SCREEN %@ <<<<<<<<<<<<<<<", screen];
    DDLogInfo(@"%@", content);
}

+ (void)writeLogContent: (NSString *)logContent
{
    NSString *content = [NSString stringWithFormat:@"%@", logContent];
    DDLogInfo(@"%@", content);
}

@end
