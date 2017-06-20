//
//  ALRichTextDemoViewController.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/20.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALRichTextDemoViewController.h"
#import "SSRollingButtonScrollView.h"
#import "WWFontDownloadManager.h"


@interface ALRichTextDemoViewController ()<SSRollingButtonScrollViewDelegate>

@end

@implementation ALRichTextDemoViewController


UIKIT_EXTERN NSString * const kFontAdobeFangsong;  //Adobe 仿宋
UIKIT_EXTERN NSString * const kFontAdobeHeiti;     //Adobe 黑体
UIKIT_EXTERN NSString * const kFontAdobeKaiti;     //Adobe 楷体
UIKIT_EXTERN NSString * const kFontAdobeSongti;    //Adobe 宋体

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *fontsArray = @{@"报隶-简":kFontBaoli,
                                 @"冬青黑体-简":kFontDongqinghei,
                                 @"仿宋":kFontFaongsong,
                                 @"黑体":kFontBlack,
                                 @"黑体-简":kFontBlackJian,
                                 @"华文仿宋":kFontHWFangsong,
                                 @"华文黑体":kFontHWBlack,
                                 @"华文琥珀":kFontHWHupo,
                                 @"华文楷体":kFontHWKaiti,
                                 @"华文隶书":kFontHWLiti,
                                 @"华文宋体":kFontHWSong,
                                 @"华文新魏":kFontHWXinwei,
                                 @"华文行楷":kFontHWXingkai,
                                 @"华文中宋":kFontHWZhongsong,
                                 @"楷体":kFontKaiti,
                                 @"楷体-简":kFontKaitiJian,
                                 @"兰亭黑-简":kFontLTBlack,
                                 @"隶变-简":kFontLibianJian,
                                 @"翩翩体-简":kFontPianpian,
                                 @"苹方-简":kFontPingFang,
                                 @"手札体-简":kFontHannotate,
                                 @"宋体":kFontSongti,
                                 @"宋体-简":kFontSongtiJian,
                                 @"娃娃体-简":kFontWawa,
                                 @"微软雅黑":kFontMicrosoftYH,
                                 @"魏碑-简":kFontWeibei,
                                 @"行楷-简":kFontXingkai,
                                 @"雅痞-简":kFontYapi,
                                 @"圆体-简":kFontYuanti,
                                 @"GB18030 Bitmap":kFontGB18030,
                                 @"MingLiU":kFontMingLiU,
                                 @"MingLiU_HKSCS Regular":kFontMingLiUHKSCS,
                                 @"PMingLiU":kFontPMingLiU,
                                 @"SimSun-ExtB Regular":kFontSimSun,
                                 @"":@"",
                                 @"":@"",
                                 @"":@"",
                                 @"":@"",
                                 @"":@"",
                                 @"":@"",
                                 @"":@"",
                                 @"":@"",
                                 @"":@"",
                                 };
    
    
    NSArray *fontsArray = [NSArray arrayWithObjects:@"报隶",@"冬青黑体",@"仿宋",@"黑体",@"黑体-简",@"华文仿宋", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
