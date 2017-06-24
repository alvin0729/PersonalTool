//
//  ALFontManager.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/21.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALFontManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ALFontFile.h"
#import "ALFontCache.h"
#import "WWFontDownloadTask.h"

NSString *const ALFontFileDownloadingNotification = @"ALFontFileDownloadingNotification";
NSString *const ALFontFileDownloadStateDidChangeNotification = @"ALFontFileDownloadStateDidChangeNotification";
NSString *const ALFontFileDownloadingDidCompleteNotification = @"ALFontFileDownloadingDidCompleteNotification";
NSString *const ALFontFileRegisteringDidCompleteNotification = @"ALFontFileRegisteringDidCompleteNotification";
NSString *const ALFontFileDeletingDidCompleteNotification = @"ALFontFileDeletingDidCompleteNotification";
NSString *const ALFontFileNotificationUserInfoKey = @"ALFontFileNotificationUserInfoKey";
static NSString *const ALFontSharedManagerName = @"ALFontSharedManagerName";


@interface ALFontManager () <NSCoding>

@property (nonatomic, strong) WWFontDownloadTask *downloader;
@property (nonatomic, copy) NSArray<ALFontFile *> *fontFiles;
@property (nonatomic, weak) ALFontFile *mainFontFile;
@property (nonatomic, copy) NSString *mainFontName;
@property (nonatomic, strong) UIFont *mainFont;
@property (nonatomic, copy) NSArray<NSString *> *nameStrings;

@end


@implementation ALFontManager

+ (instancetype)sharedManager {
    static ALFontManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = (ALFontManager *)[ALFontCache objectFromCacheWithFileName:ALFontSharedManagerName];
        if (!manager) {
            manager = [self new];
        }
    });
    return manager;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    _nameStrings = [decoder decodeObjectForKey:@"_nameStrings"];
    _fontFiles = [decoder decodeObjectForKey:@"_fontFiles"];
    _mainFontName = [decoder decodeObjectForKey:@"_mainFontName"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_nameStrings forKey:@"_nameStrings"];
    [encoder encodeObject:_fontFiles forKey:@"_fontFiles"];
    [encoder encodeObject:_mainFontName forKey:@"_mainFontName"];
}

#pragma mark - Private

- (void)archiveSelf {
    [ALFontCache cacheObject:self fileName:ALFontSharedManagerName];
}

#pragma mark - Public

+ (void)archive {
    [[ALFontManager sharedManager] archiveSelf];
}

+ (void)downloadFontFile:(ALFontFile *)file {
    [self downloadFontFile:file progress:nil completionHandler:nil];
}

+ (void)downloadFontFile:(ALFontFile *)file progress:(void(^)(ALFontFile *file))progress completionHandler:(void(^)(NSError *error))completionHandler {
    ALFontManager *sharedManager = [ALFontManager sharedManager];
    if ([sharedManager.downloader isFontDownloaded:file.fontName]) {
        if (completionHandler) {
            completionHandler(nil);
        }
        return;
    }
    [sharedManager.downloader downloadFont:file completionHandler:^(NSError *error, double progressValue) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(file);
            }
            if (progressValue > 0.99999) {
                [[NSNotificationCenter defaultCenter] postNotificationName:ALFontFileDownloadingDidCompleteNotification
                                                                    object:nil
                                                                  userInfo:@{ALFontFileNotificationUserInfoKey:file}];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:ALFontFileDownloadingNotification
                                                                    object:nil
                                                                  userInfo:@{ALFontFileNotificationUserInfoKey:file}];
            }
        });
        if (completionHandler) {
            if (error) {
                completionHandler(error);
            }else{
                completionHandler(nil);
            }
        }
    }];
}

+(void)setFontNameStrings:(NSArray<NSString *> *)fontNameStrings{
    
    ALFontManager *sharedManager = [ALFontManager sharedManager];
    if (fontNameStrings != sharedManager.nameStrings) {
        
        NSArray<ALFontFile *> *oldFontFiles = sharedManager.fontFiles;
        
        NSArray<NSString *> *oldSourceNameStrings = [oldFontFiles valueForKey:@"fontName"];
        
        NSMutableArray<ALFontFile *> *fontFiles = [NSMutableArray array];
        
        [fontNameStrings enumerateObjectsUsingBlock:^(NSString * _Nonnull nameString, NSUInteger idx, BOOL * _Nonnull stop) {
            NSUInteger index = [oldSourceNameStrings indexOfObject:nameString];
            if (!oldSourceNameStrings || index == NSNotFound) {
                ALFontFile *file = [[ALFontFile alloc] init];
                file.fontName = nameString;
                [fontFiles addObject:file];
            } else {
                ALFontFile *file = oldFontFiles[index];
                [fontFiles addObject:file];
                if ((file.downloadStatus == ALFontFileDownloadStateDownloaded) &&
                    [file.fontName isEqualToString:sharedManager.mainFontName]) {
                    sharedManager.mainFontFile = file;
                }
            }
        }];
        
        sharedManager.fontFiles = fontFiles;
        sharedManager.nameStrings = [fontNameStrings copy];
    }
}



+ (NSArray<NSString *> *)fontNameStrings {
    return [[ALFontManager sharedManager] nameStrings];
}

+ (NSArray<ALFontFile *> *)fontFiles {
    return [[ALFontManager sharedManager] fontFiles];
}

#pragma mark - Accessor

+ (UIFont *)mainFont {
    ALFontManager *sharedManager = [ALFontManager sharedManager];
    if (!sharedManager.mainFont) {
        if (sharedManager.mainFontFile) {
            sharedManager.mainFont = [UIFont fontWithName:sharedManager.mainFontName size:12.0];
        } else {
            sharedManager.mainFont = [UIFont systemFontOfSize:12.0];
        }
    }
    return sharedManager.mainFont;
}

+ (void)setMainFont:(UIFont *)mainFont {
    ALFontManager *sharedManager = [ALFontManager sharedManager];
    sharedManager.mainFont = mainFont;
    sharedManager.mainFontName = mainFont.fontName;
}

- (WWFontDownloadTask *)downloader {
    if (!_downloader) {
        _downloader = [[WWFontDownloadTask alloc] init];
    }
    return _downloader;
}


@end
