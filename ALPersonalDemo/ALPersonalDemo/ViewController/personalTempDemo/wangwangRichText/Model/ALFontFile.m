//
//  ALFontFile.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/21.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALFontFile.h"
#import "WWFontDownloadTask.h"
#import "ALFontCache.h"
#import "ALFontManager.h"


@interface ALFontFile()

@property (nonatomic, strong) NSLock *lock;

@end


@implementation ALFontFile

-(instancetype)init{
    if (self = [super init]) {
        _downloadStatus = ALFontFileDownloadStateToBeDownloaded;
        _lock = [[NSLock alloc] init];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    _fontName = [decoder decodeObjectForKey:@"_fontName"];
    _localPath = [[ALFontCache diskCacheDirectoryPath] stringByAppendingPathComponent:_fontName];
    _downloadStatus = [decoder decodeIntegerForKey:@"_downloadStatus"];
    _fileTotalSize = [decoder decodeInt64ForKey:@"_fileTotalSize"];
    _lock = [[NSLock alloc] init];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:_fontName forKey:@"_fontName"];
    if ((_downloadStatus == ALFontFileDownloadStateDownloading) || (_downloadStatus == ALFontFileDownloadStateError)) {
        _downloadStatus = ALFontFileDownloadStateToBeDownloaded;
    }
    [encoder encodeInteger:_downloadStatus forKey:@"_downloadStatus"];
    [encoder encodeInt64:_fileTotalSize forKey:@"_fileTotalSize"];
}

#pragma mark - Public


- (void)resetWithDownloadTask:(WWFontDownloadTask *)downloadTask {
    [self.lock lock];
    _downloadTask = downloadTask;
    [self.lock unlock];
}


@end
