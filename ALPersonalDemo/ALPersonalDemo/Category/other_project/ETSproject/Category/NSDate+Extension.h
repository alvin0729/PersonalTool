//
//  NSDate+Extension.h
//  Weibo11
//
//  Created by JYJ on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/// 日期描述字符串
///
/// 格式如下
///     -   刚刚(一分钟内)
///     -   X分钟前(一小时内)
///     -   X小时前(当天)
///     -   昨天 HH:mm(昨天)
///     -   MM-dd HH:mm(一年内)
///     -   yyyy-MM-dd HH:mm(更早期)
- (NSString *)ff_dateDescription;



/**
 NSString to NSDate
 */
+ (NSDate *)stringToDate:(NSString *)dateString withFormat:(NSString *)format;

/**
 获取当前时间 年月日时分 yyyy-MM-dd HH:mm
 */
+ (NSDate *)getCurrentDateWithFormat:(NSString *)format;

/**
 获取当前时间 年 YYYY
 */
+ (NSString *)getCurrentYear;

/**
 获取当前时间 月 MM
 */
+ (NSString *)getCurrentMouth;


/**
 获取当前时间 日 dd
 */
+ (NSString *)getCurrentDay;

/**
 获取当前时间 时 HH
 */
+ (NSString *)getCurrentHour;

/**
 获取当前时间 分钟 mm
 */
+ (NSString *)getCurrentMinute;
/**
 获取指定时间 分钟 mm
 */
+ (NSString *)getSelectedMinute:(NSDate *)selectedDate;
/**
 指定时间的未来N个小时的时间
 */
+ (NSDate *)priousorDateByPlusHours:(int)hours date:(NSDate *)date;

/**
 指定时间的未来N分钟的时间
 */
+ (NSDate *)priousorDateByPlusMinute:(int)minute date:(NSDate *)date;

/**
 给一个时间，给一个数，正数是以后n个月，负数是前n个月
 */
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;


/**
 指定时间与当前时间的天数间隔 YYYY-MM-DD
 */
+ (NSInteger)getDayIntervalFromDate:(NSDate *)date;



//得到当前月有多少钱
+(NSInteger)getDaysInMonth:(NSInteger)month year:(NSInteger)year;


/**
 获取目标时间 年 YYYY
 */
+ (NSString *)getTargetYear:(NSDate *)targetDate;
/**
 获取目标月 年 MM
 */
+ (NSString *)getTargetMouth:(NSDate *)targetDate;

/*
 获取目标天 dd
 */
+ (NSString *)getTargetDay:(NSDate *)targetDate;

/**
 获取目标时间 年 MM-dd
 */
+ (NSString *)getTargetMouthAndDay:(NSDate *)targetDate;



/**
 NSDate to NSString yyyy-MM-dd
 */
+ (NSString *)dateToStringYYYYMMDD:(NSDate *)dateString;


+ (NSString *)dateToStringYYYYMM:(NSDate *)dateString;

/**
 *  自定义formatter
 *
 *  @param dateString 日期
 *  @param formatter  格式
 *
 *  @return 格式化后的日期string
 */
+ (NSString *)dateToString:(NSDate *)dateString Formatter:(NSString *)formatter;

/**
 13位时间戳换算 日期
 */
+ (NSString *)returnConfromTimespStr:(NSString *)dataStr dateFormat:(NSString *)dateFormat;


/**
 创建时间格式化
 */
//传入number
+ (NSString *)changeCreatTime:(NSNumber *)creatTime;

+ (NSString *)changeCreatTimeForHHMM:(NSNumber *)creatTime;

+ (NSString *)changeCreatTime:(NSNumber *)creatTime  Formatter:(NSString *)formatter;

//传入sting
+ (NSString *)changeCreatTimeWithString:(NSString *)creatTime;

+ (NSString *)changeCreatTimeForHHMMWithString:(NSString *)creatTime;

+ (NSString *)changeCreatTimeWithSting:(NSString *)creatTime  Formatter:(NSString *)formatter;


@end
