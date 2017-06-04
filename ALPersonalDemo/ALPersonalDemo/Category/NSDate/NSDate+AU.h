//
//  NSDate+AU.h
//  微博
//
//  Created by 谢曦 on 16/1/30.
//  Copyright © 2016年 谢曦. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NSDateFormatterStyleDate,
    NSDateFormatterStyleTime,
} FormatterStyle;


@interface NSDate (AU)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

+(NSUInteger)currentYear;
+(NSUInteger)currentMonth;
+(NSUInteger)currentDay;

/**
 *  日期转字符串
 */
- (NSString *)convertToString:(FormatterStyle)style;

@end
