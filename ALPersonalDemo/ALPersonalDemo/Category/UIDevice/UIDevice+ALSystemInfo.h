//
//  UIDevice+ALSystemInfo.h
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ALSystemInfo)

+ (ALDeviceEnum) currentDeviceResolution;

+ (ALSystemVersion) currentSystemVersion;

@end
