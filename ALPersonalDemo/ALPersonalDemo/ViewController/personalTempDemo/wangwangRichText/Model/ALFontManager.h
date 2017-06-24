//
//  ALFontManager.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/21.
//  Copyright © 2017年 company. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const ALFontFileDownloadingNotification;
extern NSString *const ALFontFileDownloadStateDidChangeNotification;
extern NSString *const ALFontFileDownloadingDidCompleteNotification;
extern NSString *const ALFontFileRegisteringDidCompleteNotification;
extern NSString *const ALFontFileDeletingDidCompleteNotification;
extern NSString *const ALFontFileNotificationUserInfoKey;


@class ALFontFile;
@interface ALFontManager : NSObject

+ (void)archive;
+ (void)downloadFontFile:(ALFontFile *)file;
+ (void)downloadFontFile:(ALFontFile *)file
                progress:(void(^)(ALFontFile *file))progress
       completionHandler:(void(^)(NSError *error))completionHandler;

@property (class, nonatomic, copy, readonly) NSArray<ALFontFile *> *fontFiles;
@property (class, nonatomic, copy) NSArray<NSString *> *fontNameStrings;
@property (class, nonatomic, strong) UIFont *mainFont;

@end
