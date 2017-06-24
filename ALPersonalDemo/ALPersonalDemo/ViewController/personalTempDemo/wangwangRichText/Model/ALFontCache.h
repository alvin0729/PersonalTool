//
//  ALFontCache.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/21.
//  Copyright © 2017年 company. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALFontFile;

@interface ALFontCache : NSObject

+ (BOOL)cacheObject:(id)object fileName:(NSString *)fileName;
+ (id)objectFromCacheWithFileName:(NSString *)fileName;

+ (void)cacheFile:(ALFontFile *)file completionHandler:(void(^)(NSError *error))completionHandler ;
+ (void)cleanCachedFile:(ALFontFile *)file completionHandler:(void(^)(NSError *error))completionHandler;

+ (NSString *)diskCacheDirectoryPath;

@end
