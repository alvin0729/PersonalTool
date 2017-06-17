//
//  MHConstant.h
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/7.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// category
//#import "UIBarButtonItem+MHExtension.h"
//#import "UIView+MH.h"
#import "UIFont+MHExtension.h"
//#import "NSString+MH.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
//#import "NSObject+MH.h"
//#import "Colours.h"
//#import "UIImage+MH.h"
//#import "UIViewController+MHDismissKeyboard.h"
//#import "UIViewController+MHHUD.h"
//#import "NSDate+Extension.h"
//#import "MBProgressHUD+MH.h"


// tool
//#import "MHWebImageTool.h"
//#import "MHSingleton.h"
//#import "Masonry.h"
//#import "JPFPSStatus.h"
//#import "LxDBAnything.h"
//#import "ReactiveCocoa.h"


// UIKit
//#import "MHButton.h"
//#import "YYText.h"
//#import "MHImageView.h"
//#import "MHDivider.h"
//#import "MHBackButton.h"

// 模型
#import "AppDelegate.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// 适配AF
#ifndef TARGET_OS_IOS

#define TARGET_OS_IOS TARGET_OS_IPHONE

#endif

#ifndef TARGET_OS_WATCH

#define TARGET_OS_WATCH 0

#endif


// 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%zd行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

// 日记输出宏
#ifdef DEBUG // 调试状态, 打开LOG功能
#define MHLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define MHLog(...)
#endif

// 打印方法
#define MHLogFunc MHLog(@"%s", __func__)


// 打印请求错误信息
#define MHLogErrorMessage  MHLog(@"错误请求日志-----【 %@ 】--【 %@ 】",[self class] , error.mh_message)


// KVO获取监听对象的属性 有自动提示
// 宏里面的#，会自动把后面的参数变成c语言的字符串
#define MHKeyPath(objc,keyPath) @(((void)objc.keyPath ,#keyPath))


// 颜色
#define MHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 颜色+透明度
#define MHAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


// 随机色
#define MHRandomColor MHColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
// 根据rgbValue获取值
#define MHColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/**
 * 设置颜色
 */
#define MHColorFromHexString(__hexString__) [UIColor colorWithHexString:__hexString__]

// 是否为iOS7+
#define MHIOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 是否为4inch
#define MHFourInch ([UIScreen mainScreen].bounds.size.height == 568.0)

// 屏幕总尺寸
#define MHMainScreenBounds  [UIScreen mainScreen].bounds
#define MHMainScreenHeight  [UIScreen mainScreen].bounds.size.height
#define MHMainScreenWidth   [UIScreen mainScreen].bounds.size.width

// IOS版本
#define MHIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

// 销毁打印
#define MHDealloc MHLog(@"\n =========+++ %@  销毁了 +++======== \n",[self class])

// 是否为空对象
#define MHObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define MHStringIsEmpty(__string) ((__string.length == 0) || MHObjectIsNil(__string))

// 字符串不为空
#define MHStringIsNotEmpty(__string)  (!MHStringIsEmpty(__string))

// 数组为空
#define MHArrayIsEmpty(__array) ((MHObjectIsNil(__array)) || (__array.count==0))

// 取消ios7以后下移
#define MHDisabledAutomaticallyAdjustsScrollViewInsets \
if (MHIOSVersion>=7.0) {\
self.automaticallyAdjustsScrollViewInsets = NO;\
}

// AppCaches 文件夹路径
#define MHCachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

// App DocumentDirectory 文件夹路径
#define MHDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]

// 系统放大倍数
#define MHScale [[UIScreen mainScreen] scale]

/**
 *  Frame PX  ---> Pt 6的宽度 全部向下取整数
 */
#define MHPxConvertPt(__Px) floor((__Px) * MHMainScreenWidth/375.0f)
/**
 *  Frame PX  ---> Pt 6的宽度 返回一个合适的值 按钮手指触摸点 44
 */
#define MHFxConvertFitPt(__px) (MAX(MHPxConvertPt(__Px),44))

#define MHIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
// 设置图片
#define MHImageNamed(__imageName) [UIImage imageNamed:__imageName]
/**
 *  通知中心
 */
#define MHNotificationCenter [NSNotificationCenter defaultCenter]


/**
 * 设置颜色
 */
#define MHcolorWithHexString(__hexString__) [UIColor colorWithHexString:__hexString__]

/**
 *  全局灰色色字体颜色 + placeHolder字体颜色
 */
#define MHGlobalGrayTextColor       [UIColor colorWithHexString:@"#999999"]

/**
 *  全局白色字体
 */
#define MHGlobalWhiteTextColor      [UIColor colorWithHexString:@"#ffffff"]

/**
 *  全局黑色字体
 */
#define MHGlobalBlackTextColor      [UIColor colorWithHexString:@"#323232"]
/**
 *  全局浅黑色字体
 */
#define MHGlobalShadowBlackTextColor      [UIColor colorWithHexString:@"#646464"]

/**
 *  全局灰色 背景
 */
#define MHGlobalGrayBackgroundColor [UIColor colorWithHexString:@"#f8f8f8"]

/**
 *  全局细下滑线颜色 以及分割线颜色
 */
#define MHGlobalBottomLineColor     [UIColor colorWithHexString:@"#d6d7dc"]

/**
 *  全局橙色
 */
#define MHGlobalOrangeTextColor      [UIColor colorWithHexString:@"#FF9500"]

/**
 *  全局细线高度 .75f
 */
UIKIT_EXTERN CGFloat const MHGlobalBottomLineHeight;

/**
 *  UIView 动画时长
 */
UIKIT_EXTERN NSTimeInterval const MHAnimateDuration ;

/**
 *  全局控制器顶部间距 10
 */
UIKIT_EXTERN CGFloat const MHGlobalViewTopInset;

/**
 *  全局控制器左边间距 12
 */
UIKIT_EXTERN CGFloat const MHGlobalViewLeftInset;

/**
 *  全局控制器中间间距 10
 */
UIKIT_EXTERN CGFloat const MHGlobalViewInterInset;


/**
 *  全局默认头像
 */
#define MHGlobalUserDefaultAvatar [UIImage imageNamed:@"mh_defaultAvatar"]


// 父子控制器
/** 百思不得姐 -顶部标题的高度 */
UIKIT_EXTERN CGFloat const MHTitilesViewH;
/** 百思不得姐-顶部标题的Y */
UIKIT_EXTERN CGFloat const MHTitilesViewY;

/** 网易新闻-颜色 R、G、B、A*/
UIKIT_EXTERN CGFloat const MHTopicLabelRed;
UIKIT_EXTERN CGFloat const MHTopicLabelGreen;
UIKIT_EXTERN CGFloat const MHTopicLabelBlue;
UIKIT_EXTERN CGFloat const MHTopicLabelAlpha;



// 仿微信朋友圈评论和回复
// 段头+cell+表头
/**  话题头像宽高 */
UIKIT_EXTERN CGFloat const MHTopicAvatarWH ;
/**  话题水平方向间隙 */
UIKIT_EXTERN CGFloat const MHTopicHorizontalSpace;
/**  话题垂直方向间隙 */
UIKIT_EXTERN CGFloat const MHTopicVerticalSpace ;
/**  话题更多按钮宽 */
UIKIT_EXTERN CGFloat const MHTopicMoreButtonW ;


/**  话题内容字体大小 */
#define MHTopicTextFont MHMediumFont(12.0f)
/**  话题昵称字体大小 */
#define MHTopicNicknameFont MHMediumFont(10.0f)
/**  话题点赞字体大小 */
#define MHTopicThumbFont MHMediumFont(10.0f)
/**  话题时间字体大小 */
#define MHTopicCreateTimeFont MHMediumFont(10.0f)




/**  评论水平方向间隙 */
UIKIT_EXTERN CGFloat const MHCommentHorizontalSpace ;
/**  评论垂直方向间隙 */
UIKIT_EXTERN CGFloat const MHCommentVerticalSpace;

/**  评论内容字体大小 */
#define MHCommentTextFont MHMediumFont(12.0f)

/** 文本行高 */
UIKIT_EXTERN CGFloat const  MHCommentContentLineSpacing;


/** 评论假数据 */
UIKIT_EXTERN NSString * const MHAllCommentsId ;


/** 评论用户的key */
UIKIT_EXTERN NSString * const MHCommentUserKey ;


/** 评论高度 */
UIKIT_EXTERN CGFloat const MHCommentHeaderViewHeight;

/** 评论工具高度 */
UIKIT_EXTERN CGFloat const MHCommentToolBarHeight    ;

/** 最大字数 */
UIKIT_EXTERN NSInteger const MHCommentMaxWords    ;

/** 每页数据 */
UIKIT_EXTERN NSUInteger const MHCommentMaxCount ;

/** 弹出评论框View最小距离 */
UIKIT_EXTERN CGFloat const MHTopicCommentToolBarMinHeight ;

/** 弹出评论框View的除了编辑框的高度 */
UIKIT_EXTERN CGFloat const MHTopicCommentToolBarWithNoTextViewHeight ;


/** 视频评论成功的通知 */
UIKIT_EXTERN NSString * const MHCommentSuccessNotification ;
/** 视频评论成功Key */
UIKIT_EXTERN NSString * const MHCommentSuccessKey ;

/** 视频点赞成功的通知 */
UIKIT_EXTERN NSString * const MHThumbSuccessNotification ;



/** 视频评论回复成功的通知 */
UIKIT_EXTERN NSString * const MHCommentReplySuccessNotification ;
/** 视频评论回复成功Key */
UIKIT_EXTERN NSString * const MHCommentReplySuccessKey ;

/** 视频评论获取成功的事件 */
UIKIT_EXTERN NSString * const MHCommentRequestDataSuccessNotification  ;
/** 视频评论获取成功的事件 */
UIKIT_EXTERN NSString * const MHCommentRequestDataSuccessKey  ;


/** 弹出评论框View距离顶部的最小高度 */
#define MHTopicCommentToolBarMinTopInset (MHMainScreenWidth * 9.0f/16.0f + 20)


/** titleView高度 */
UIKIT_EXTERN CGFloat const MHRecommendTitleViewHeight;
/** 选集view高度 */
UIKIT_EXTERN CGFloat const MHRecommendAnthologyViewHeight;
/** 选集纯文本HeaderView高度 */
UIKIT_EXTERN CGFloat const MHRecommendAnthologyHeaderViewHeight;

/** 评论高度 */
UIKIT_EXTERN CGFloat const MHRecommendCommentHeaderViewHeight;
