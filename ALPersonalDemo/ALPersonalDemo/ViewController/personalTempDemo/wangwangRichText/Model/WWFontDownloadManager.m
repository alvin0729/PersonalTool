//
//  WWFontDownloadManager.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/20.
//  Copyright © 2017年 company. All rights reserved.
//

#import "WWFontDownloadManager.h"
#import <CoreText/CoreText.h>

NSString * const kFontBaoli = @"STBaoli-SC-Regular";          //报隶-简
NSString * const kFontDongqinghei = @"HiraginoSansGB-W3";    //冬青黑体-简
NSString * const kFontFaongsong = @"FangSong";      //仿宋
NSString * const kFontBlack = @"SimHei";          //黑体
NSString * const kFontBlackJian = @"STHeitiSC-Light";      //黑体-简
NSString * const kFontHWFangsong = @"STFangsong";     //华文仿宋
NSString * const kFontHWBlack = @"STXihei";        //华文黑体
NSString * const kFontHWHupo = @"STHupo";         //华文琥珀
NSString * const kFontHWKaiti = @"STKaiti";        //华文楷体
NSString * const kFontHWLiti = @"STLiti";         //华文隶书
NSString * const kFontHWSong = @"STSong";         //华文宋体
NSString * const kFontHWXinwei = @"STXinwei";       //华文新魏
NSString * const kFontHWXingkai = @"STXingkai";      //华文行楷
NSString * const kFontHWZhongsong = @"STZhongsong";    //华文中宋
NSString * const kFontKaiti = @"KaiTi";          //楷体
NSString * const kFontKaitiJian = @"STKaiti-SC-Regular";      //楷体-简
NSString * const kFontLTBlack = @"FZLTXHK--GBK1-0";        //兰亭黑-简
NSString * const kFontLibianJian = @"STLibian-SC-Regular";     //隶变-简
NSString * const kFontPianpian = @"HanziPenSC-W3";       //翩翩体-简
NSString * const kFontPingFang = @"PingFangSC-Regular";       //苹方-简
NSString * const kFontHannotate = @"HannotateSC-W5";      //手札体-简
NSString * const kFontSongti = @"SimSun";         //宋体
NSString * const kFontSongtiJian = @"STSongti-SC-Regular";     //宋体-简
NSString * const kFontWawa = @"DFWaWaSC-W5";           //娃娃体-简
NSString * const kFontMicrosoftYH = @"MicrosoftYaHei";    //微软雅黑
NSString * const kFontWeibei = @"Weibei-SC-Bold";         //魏碑-简
NSString * const kFontXingkai = @"STXingkai-SC-Light";        //行楷-简
NSString * const kFontYapi = @"YuppySC-Regular";           //雅痞-简
NSString * const kFontYuanti = @"STYuanti-SC-Regular";         //圆体-简
NSString * const kFontGB18030 = @"GB18030Bitmap";        //GB18030 Bitmap
NSString * const kFontMingLiU = @"MingLiU";        //MingLiU
NSString * const kFontMingLiUHKSCS = @"Ming-Lt-HKSCS-UNI-H";   //MingLiU_HKSCS Regular
NSString * const kFontPMingLiU = @"PMingLiU";       //PMingLiU
NSString * const kFontSimSun = @"SimSun-ExtB";         //SimSun-ExtB Regular
NSString * const kFontAdobeFangsong = @"AdobeFangsongStd-Regular";  //Adobe 仿宋
NSString * const kFontAdobeHeiti = @"AdobeHeitiStd-Regular";     //Adobe 黑体
NSString * const kFontAdobeKaiti = @"AdobeKaitiStd-Regular";     //Adobe 楷体
NSString * const kFontAdobeSongti = @"AdobeSongStd-Light";    //Adobe 宋体

@interface WWFontDownloadManager(){
    NSString *_errorMessage;
    NSString *_postName;
}

@end

@implementation WWFontDownloadManager

+ (BOOL)isFontDownloaded:(NSString*)fontName{
    UIFont* font = [UIFont fontWithName:fontName size:12.0];
    if (font && ([font.fontName compare:fontName] == NSOrderedSame || [font.familyName compare:fontName] == NSOrderedSame)) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)downloadFont:(NSString*)fontName succeed:(void(^)(NSError* error, double progressValue))succeed{
    //用字体的PostScript名字创建一个Dictionary
    NSMutableDictionary* attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    //创建一个字体描述对象CTFontDescriptorRef
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    //将字体描述对象放到一个NSMutableArray中
    NSMutableArray* descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    //匹配字体
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef _Nonnull progressParameter) {
        
        if (state == kCTFontDescriptorMatchingDidBegin) {//字体已经匹配
            
        } else if (state == kCTFontDescriptorMatchingDidFinish) {//字体下载完成
            if (!errorDuringDownload) {
                dispatch_async( dispatch_get_main_queue(), ^ {
                    if (succeed) {
                        succeed(nil,1.0);
                    }
                    return ;
                });
            }
        }
        return (BOOL)YES;
    });
    
    
    //下载
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler((__bridge CFArrayRef)descs, NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        double progressValue = [[(__bridge NSDictionary*)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        if(kCTFontDescriptorMatchingDidBegin == state){
            ALAppLog(@"字体已经匹配");
        }else if (kCTFontDescriptorMatchingDidFinish == state){
            if (!errorDuringDownload) {
                ALAppLog(@"%@字体下载完成", fontName);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (succeed) {
                        succeed(nil,1.0);
                    }
                });
            }
        }else if (kCTFontDescriptorMatchingWillBeginDownloading == state){
            ALAppLog(@"字体开始下载");
        }else if (kCTFontDescriptorMatchingDidFinishDownloading == state){
            ALAppLog(@"字体开始完成");
        }else if (kCTFontDescriptorMatchingDownloading == state){
            ALAppLog(@"下载进度:%.0f%%", progressValue);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (succeed) {
                    succeed(nil,progressValue);
                }
            });
        }else if (kCTFontDescriptorMatchingDidFailWithError == state){
            errorDuringDownload = YES;
            NSError* error = [(__bridge NSDictionary*)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (!error) {
                ALAppLog(@"%@", error.description);
                if (succeed) {
                    succeed([NSError errorWithDomain:error.description code:error.code userInfo:nil],0);
                }
            }else{
                ALAppLog(@"ERROR MESSAGE IS NOT AVAILABLE!");
                if (succeed) {
                    succeed([NSError errorWithDomain:@"ERROR MESSAGE IS NOT AVAILABLE!" code:-1000 userInfo:nil],0);
                }
            }
        }
        return (BOOL)YES;
    });
}

+ (UIFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize{
    if ([WWFontDownloadManager isFontDownloaded:fontName]) {
        return [UIFont fontWithName:fontName size:fontSize];
    }else{
        return nil;
    }
}

@end







