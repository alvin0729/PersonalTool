//
//  NSString+extension.h
//  DongDongWedding
//
//  Created by 谢曦 on 2016/11/10.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extension)
//时间戳转时间 2016-11-20 12:20:30
+(NSString *)timeStrFromTimeStamp:(NSString *)timeStamp;
//时间戳转时间 2016-11-20 
+(NSString *)timeDateStrFromTimeStamp:(NSString *)timeStamp;
//时间转时间戳(date-->时间戳)
+(NSString *)stampFromTimeDate:(NSDate *)time;
//时间转时间戳(str-->时间戳)
+(NSString *)stampFromTimeStr:(NSString *)timeStr;
//Base64加密
+(NSString *)Base64CodeWithStr:(NSString *)str;
+ (BOOL)stringContainsEmoji:(NSString *)string;
- (BOOL) isBlankString;
@end
