//
//  ALFontFile.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/21.
//  Copyright © 2017年 company. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALFontModel, UIFont, WWFontDownloadTask;

typedef NS_ENUM(NSUInteger, ALFontFileDownloadState) {
    ALFontFileDownloadStateToBeDownloaded,
    ALFontFileDownloadStateDownloading,
    ALFontFileDownloadStateDownloaded,
    ALFontFileDownloadStateError,
};


@interface ALFontFile : NSObject<NSCoding>

@property (nonatomic, assign) int64_t fileTotalSize;
@property (nonatomic, assign) int64_t fileDownloadedSize;
@property (nonatomic, assign) double downloadProgress;
@property (nonatomic, assign) BOOL fileSizeUnknown;
@property (nonatomic, copy) NSError *downloadError;

@property (nonatomic, assign) ALFontFileDownloadState downloadStatus;
@property (nonatomic, strong) WWFontDownloadTask *downloadTask;

@property (nonatomic, copy) NSString *localPath;
@property (nonatomic, copy) NSString *fontName;


- (void)resetWithDownloadTask:(WWFontDownloadTask *)downloadTask;

@end


//NSDictionary *attrs = @{NSFontAttributeName : font};
//return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;


