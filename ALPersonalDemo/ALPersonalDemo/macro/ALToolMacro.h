//
//  ALToolMacro.h
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#ifndef ALToolMacro_h
#define ALToolMacro_h

//void ALAppLog(NSString *format, ...) {
//#ifdef DEBUG
//    va_list argptr;
//    va_start(argptr, format);
//    NSLogv(format, argptr);
//    va_end(argptr);
//#endif
//}

#ifdef DEBUG
#define ALAppLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define ALAppLog(...)
#define debugMethod()
#endif




#endif /* ALToolMacro_h */
