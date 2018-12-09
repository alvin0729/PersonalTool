//
//  TJCommonDefines.swift
//  TJCommonKit
//
//  Created by tao on 2018/10/19.
//  Copyright © 2018年 tao. All rights reserved.
//

import UIKit

///获取屏幕大小
let TJ_SCREEN_WIDTH = UIScreen.main.bounds.size.width
let TJ_SCREEN_HEIGHT = UIScreen.main.bounds.size.height

///机型判断
let TJ_SCREEN_MAX_LENGTH  = max(TJ_SCREEN_WIDTH, TJ_SCREEN_HEIGHT)
let TJ_IS_IPHONE_4_OR_LESS = TJ_SCREEN_MAX_LENGTH < 568.0
let TJ_IS_IPHONE_5 = TJ_SCREEN_MAX_LENGTH == 568.0
let TJ_IS_IPHONE_6 = TJ_SCREEN_MAX_LENGTH == 667.0
let TJ_IS_IPHONE_6P = TJ_SCREEN_MAX_LENGTH == 736.0
let TJ_IS_IPHONE_X = TJ_SCREEN_MAX_LENGTH == 812.0

///获取状态栏、标题栏、导航栏高度
let TJ_STATUS_NAV_BAR_Y:CGFloat = TJ_IS_IPHONE_X == true ? 88.0 : 64.0
let TJ_TABBAR_HEIGHT:CGFloat = TJ_IS_IPHONE_X == true ? 83.0 : 49.0
let TJ_STATUSBAR_HEIGHT:CGFloat = TJ_IS_IPHONE_X == true ? 44.0 : 20.0

///APP版本号
let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
///当前系统版本号
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
///检测用户版本号
let kiOS12 = (kVersion >= 12.0)
let kiOS11 = (kVersion >= 11.0 && kVersion < 12.0)
let kiOS10 = (kVersion >= 10.0 && kVersion < 11.0)
let kiOS9 = (kVersion >= 9.0 && kVersion < 10.0)
let kiOS8 = (kVersion >= 8.0 && kVersion < 9.0)
let kiOS12Later = (kVersion >= 12.0)
let kiOS11Later = (kVersion >= 11.0)
let kiOS10Later = (kVersion >= 10.0)
let kiOS9Later = (kVersion >= 9.0)
let kiOS8Later = (kVersion >= 8.0)

///颜色
let GRAY5_COLOR = UIColor(red: 224.0/255, green: 224.0/255, blue: 224.0/255, alpha: 1.0)
let BACKVIEW_COLOR = UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0)

