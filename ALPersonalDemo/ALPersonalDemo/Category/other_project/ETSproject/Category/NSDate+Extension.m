//
//  NSDate+Extension.m
//  Weibo11
//
//  Created by JYJ on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSString *)ff_dateDescription {
    
    // 1. 获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 2. 判断是否是今天
    if ([calendar isDateInToday:self]) {
        
        NSInteger interval = ABS((NSInteger)[self timeIntervalSinceNow]);

        if (interval < 60) {
            return @"刚刚";
        }
        interval /= 60;
        if (interval < 60) {
            return [NSString stringWithFormat:@"%zd 分钟前", interval];
        }
        
        return [NSString stringWithFormat:@"%zd 小时前", interval / 60];
    }
    
    // 3. 昨天
    NSMutableString *formatString = [NSMutableString stringWithString:@" HH:mm"];
    if ([calendar isDateInYesterday:self]) {
        [formatString insertString:@"昨天" atIndex:0];
    } else {
        [formatString insertString:@"MM-dd" atIndex:0];
        
        // 4. 是否当年
        NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self toDate:[NSDate date] options:0];

        if (components.year != 0) {
            [formatString insertString:@"yyyy-" atIndex:0];
        }
    }

    // 5. 转换格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    fmt.dateFormat = formatString;
    
    return [fmt stringFromDate:self];
}


+ (NSDate *)getCurrentDate;
{
    //    NSLog(@"%@",    [NSTimeZone knownTimeZoneNames]);
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString *todayTime = [dateFormatter stringFromDate:today];
    return [self stringToDate:todayTime withFormat:@"yyyy-MM-dd HH:mm"];
}

+ (NSDate *)getCurrentDateWithFormat:(NSString *)format
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString *todayTime = [dateFormatter stringFromDate:today];
    return [self stringToDate:todayTime withFormat:format];
}

+ (NSString *)getCurrentYear
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * year = [dateFormatter stringFromDate:today];
    return year;
    
}

+ (NSString *)getCurrentMouth
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * mouth = [dateFormatter stringFromDate:today];
    return mouth;
    
}

+ (NSString *)getCurrentDay
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * day = [dateFormatter stringFromDate:today];
    return day;
}

+ (NSString *)getCurrentHour
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * hours = [dateFormatter stringFromDate:today];
    return hours;
}

+ (NSString *)getCurrentMinute
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"mm"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * hours = [dateFormatter stringFromDate:today];
    return hours;
}

+ (NSString *)getSelectedMinute:(NSDate *)selectedDate
{
    // NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"mm"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * hours = [dateFormatter stringFromDate:selectedDate];
    return hours;
}



+ (NSDate *)priousorDateByPlusHours:(int)hours date:(NSDate *)date
{
    NSTimeInterval interval = date.timeIntervalSinceReferenceDate;
    interval += 3600 * hours;
    NSDate * newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:interval];
    return newDate;
}

+ (NSDate *)priousorDateByPlusMinute:(int)minute date:(NSDate *)date
{
    NSTimeInterval interval = date.timeIntervalSinceReferenceDate;
    interval += 60 * minute;
    NSDate * newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:interval];
    
    return newDate;
}

+ (NSDate *)stringToDate:(NSString *)dateString withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDate * date = [dateFormatter dateFromString:dateString];
    return date;
}



+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
    
}

/**
 指定时间与当前时间的天数间隔 YYYY-MM-DD
 */
+ (NSInteger)getDayIntervalFromDate:(NSDate *)date
{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate * startDate = [NSDate getCurrentDateWithFormat:@"yyyy-MM-dd"];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate toDate:date options:0];
    NSInteger days = [comps day];
    return days;
    
}


+(NSInteger)getDaysInMonth:(NSInteger)month year:(NSInteger)year
{
    int daysInFeb = 28;
    if (year%4 == 0) {
        daysInFeb = 29;
    }
    int daysInMonth [12] = {31,daysInFeb,31,30,31,30,31,31,30,31,30,31};
    return daysInMonth[month-1];
}


/**
 获取目标时间 年 YYYY
 */
+ (NSString *)getTargetYear:(NSDate *)targetDate
{
    //    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * year = [dateFormatter stringFromDate:targetDate];
    return year;
    
}
/**
 获取目标月 年 MM
 */
+ (NSString *)getTargetMouth:(NSDate *)targetDate
{
    //    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * mouth = [dateFormatter stringFromDate:targetDate];
    return mouth;
}
+ (NSString *)getTargetDay:(NSDate *)targetDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * day = [dateFormatter stringFromDate:targetDate];
    return day;
}

/**
 获取目标时间 年 MM-dd
 */
+ (NSString *)getTargetMouthAndDay:(NSDate *)targetDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString * day = [dateFormatter stringFromDate:targetDate];
    return day;
}


+ (NSString *)dateToStringYYYYMMDD:(NSDate *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [dateFormatter stringFromDate:dateString];
    return string;
}

+ (NSString *)dateToStringYYYYMM:(NSDate *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *string = [dateFormatter stringFromDate:dateString];
    return string;
}



+ (NSString *)dateToString:(NSDate *)dateString Formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *string = [dateFormatter stringFromDate:dateString];
    return string;
}

+ (NSString *)returnConfromTimespStr:(NSString *)dataStr dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setDateFormat:dateFormat];

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataStr.integerValue/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


+ (NSString *)changeCreatTime:(NSNumber *)creatTime
{
    long long time = [creatTime longLongValue];
    long long  times =  time/1000;
    NSDate *creatDate = [NSDate dateWithTimeIntervalSince1970:times];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //hh:mm:ss
    NSString *dateTime =  [dateFormatter stringFromDate:creatDate];
    
    return dateTime;
}

+ (NSString *)changeCreatTime:(NSNumber *)creatTime  Formatter:(NSString *)formatter
{
    long long time = [creatTime longLongValue];
    long long  times =  time/1000;
    NSDate *creatDate = [NSDate dateWithTimeIntervalSince1970:times];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter]; //hh:mm:ss
    NSString *dateTime =  [dateFormatter stringFromDate:creatDate];
    
    return dateTime;
}


+ (NSString *)changeCreatTimeForHHMM:(NSNumber *)creatTime
{
    long long time = [creatTime longLongValue];
    long long  times =  time/1000;
    NSDate *creatDate = [NSDate dateWithTimeIntervalSince1970:times];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"]; //hh:mm:ss
    NSString *dateTime =  [dateFormatter stringFromDate:creatDate];
    
    return dateTime;
}

+ (NSString *)changeCreatTimeForHHMMWithString:(NSString *)creatTime
{
    if (creatTime.length > 0) {
        long long time = [creatTime longLongValue];
        long long  times =  time/1000;
        NSDate *creatDate = [NSDate dateWithTimeIntervalSince1970:times];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"HH:mm"]; //hh:mm:ss
        NSString *dateTime =  [dateFormatter stringFromDate:creatDate];
        
        return dateTime;
    }
    return @"";
}

+ (NSString *)changeCreatTimeWithString:(NSString *)creatTime
{
    if (creatTime.length > 0) {
        long long time = [creatTime longLongValue];
        long long  times =  time/1000;
        NSDate *creatDate = [NSDate dateWithTimeIntervalSince1970:times];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //hh:mm:ss
        NSString *dateTime =  [dateFormatter stringFromDate:creatDate];
        
        return dateTime;
    }
    return @"";
}

+ (NSString *)changeCreatTimeWithSting:(NSString *)creatTime  Formatter:(NSString *)formatter
{
    if (creatTime.length > 0) {
        long long time = [creatTime longLongValue];
        long long  times =  time/1000;
        NSDate *creatDate = [NSDate dateWithTimeIntervalSince1970:times];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:formatter]; //hh:mm:ss
        NSString *dateTime =  [dateFormatter stringFromDate:creatDate];
        
        return dateTime;
    }
    return @"";
}


@end
