//
//  ALEnumList.h
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#ifndef ALEnumList_h
#define ALEnumList_h

/** 机型设备信息 用ALDeviceEnum作为下标访问*/
#define kDeviceArray @[@"iPhone_4",@"iPhone_4s",@"iPhone_5",@"iPhone_5c",@"iPhone_5s",@"iPhone_6",@"iPhone_6p",@"iPhone_6s",@"iPhone_6sp",@"iPhone_se",@"iPhone_7",@"iPhone_7p",@"Simulator"]

typedef NS_ENUM(NSUInteger,ALDeviceEnum){
    Device_iPhone_4 = 0 ,
    Device_iPhone_4s    ,
    Device_iPhone_5     ,
    Device_iPhone_5c    ,
    Device_iPhone_5s    ,
    Device_iPhone_6     ,
    Device_iPhone_6p    ,
    Device_iPhone_6s    ,
    Device_iPhone_6sp   ,
    Device_iPhone_se    ,
    Device_iPhone_7     ,
    Device_iPhone_7p    ,
    Device_Simulator
};

typedef NS_ENUM(NSUInteger,ALSystemVersion){
    Version_iOS7 = 0    ,
    Version_iOS8        ,
    Version_iOS9        ,
    Version_iOS10       ,
    Version_noSupport
};



#endif /* ALEnumList_h */
