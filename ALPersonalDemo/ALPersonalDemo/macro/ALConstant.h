//
//  ALConstant.h
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#ifndef ALConstant_h
#define ALConstant_h


// NavigationBar高度
#define kNavigationBar_HEIGHT 44

#pragma mark - 设备信息
#define kIOS_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]
#define kDEVICE_MODEL   [[UIDevice currentDevice] model]
#define kIS_IPAD        ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define kAPP_NAME            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kAPP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAPP_SUB_VERSION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kUDeviceIdentifier   [[UIDevice currentDevice] uniqueDeviceIdentifier]
// 当前系统语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark - ios版本判断
#define kIOS5_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define kIOS6_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define kIOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define kIOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define kIOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )

//=============================判断当前系统版本号==============================//

#define kSYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define kSYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define kSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define kSYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define kSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - 设备类型
#define kiPhone4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define isRetina     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - 颜色
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kCOLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - 定义字体大小
#define kFONT_TITLE(X)     [UIFont systemFontSize:X]
#define kFONT_CONTENT(X)   [UIFont systemFontSize:X]

#pragma mark - 屏幕相关
#define kALScreenHeight ([[UIScreen mainScreen] bounds].size.height - (kIOS7_OR_LATER?0:20))
#define kALScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
#define kRELATIVE_W(pt)                      pt * SCREEN_WIDTH / 375
#define kRELATIVE_H(pt)                      pt * SCREEN_HEIGHT / 667
#define kView_WIDTH(view)   view.frame.size.width
#define kView_HEIGHT(view)  view.frame.size.height
#define kView_LEFTX(view)   view.frame.origin.x
#define kView_TOPY(view)    view.frame.origin.y
//右下角横坐标
#define kView_RIGHTX(view)  (kView_LEFTX(view) + kView_WIDTH(view))
//右下角纵坐标
#define kView_BOTTOMY(view) (kView_TOPY(view) + kView_HEIGHT(view))

// AppDelegate
#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

// Storyboard通过名字获取
#define kStoryboard(StoryboardName)   [UIStoryboard storyboardWithName:StoryboardName bundle:nil]

#pragma mark - GCD
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// 移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}\

// Docment文件夹目录
#pragma mark - Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

//=================================角度&弧度相互转换=================================//
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)




#endif /* ALConstant_h */
