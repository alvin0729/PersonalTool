//
//  ALFontCache.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/21.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALFontCache.h"
#import <CommonCrypto/CommonDigest.h>
#import "ALFontFile.h"
#import "ALFontManager.h"
#import "RichTextConstant.h"

static NSString * const ALFontCacheDirectoryName = @"WWFont";

@implementation ALFontCache

#pragma mark - Public

+ (BOOL)cacheObject:(id)object fileName:(NSString *)fileName {
    NSString *cachePath = [[self diskCacheDirectoryPath] stringByAppendingPathComponent:fileName];
    NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:object];
    return [cacheData writeToFile:cachePath atomically:YES];
}

+ (id)objectFromCacheWithFileName:(NSString *)fileName {
    NSString *cachePath = [[self diskCacheDirectoryPath] stringByAppendingPathComponent:fileName];
    NSData *cacheData = [NSData dataWithContentsOfFile:cachePath];
    if (cacheData) {
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
        return obj;
    } else {
        return nil;
    }
}

+ (void)cacheFile:(ALFontFile *)file
completionHandler:(void(^)(NSError *))completionHandler {
    
    NSError *error = nil;
    BOOL cacheSuccess = [self cacheObject:file fileName:file.fontName];
    if (cacheSuccess) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:ALFontFileDownloadingDidCompleteNotification
                                                                object:nil
                                                              userInfo:@{ALFontFileNotificationUserInfoKey:file}];
        });
    }
    
    if (completionHandler) {
        completionHandler(error);
    }
}

+ (void)cleanCachedFile:(ALFontFile *)file completionHandler:(void(^)(NSError *))completionHandler {
    NSError *error = nil;
    BOOL removeSuccess = [[NSFileManager defaultManager] removeItemAtPath:file.localPath error:&error];
    
    if (removeSuccess) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:ALFontFileDeletingDidCompleteNotification
                                                                object:nil
                                                              userInfo:@{ALFontFileNotificationUserInfoKey:file}];
        });
    }
    if (completionHandler) {
        completionHandler(error);
    }
}

+ (NSString *)diskCacheDirectoryPath {
    static NSString *_diskCacheDirectoryPath;
    if (!_diskCacheDirectoryPath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        
        _diskCacheDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:ALFontCacheDirectoryName];
        NSError *error = nil;
        [fileManager createDirectoryAtPath:_diskCacheDirectoryPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
    }
    return _diskCacheDirectoryPath;
}

#pragma mark - Private

+ (NSString *)filePathForSourceURLString:(NSString *)URLString {
    const char *str = [URLString UTF8String];
    if (str == NULL) {
        return @"";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
            r[11], r[12], r[13], r[14], r[15]];
}

@end

