//
//  NSDate+SNFoundation.m
//  SNFoundation
//
//  Created by liukun on 14-3-4.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "NSDate+SNFoundation.h"

@implementation NSDate (SNFoundation)

+ (NSDate *)getDate:(NSString *)dateStr pattern:(NSString *)ptn
{
    NSLocale *locale = [NSLocale currentLocale];
    
    return [self getDate:dateStr pattern:ptn locale:locale];
}

+ (NSDate *)getDate:(NSString *)sDate pattern:(NSString *)ptn locale:(NSLocale *)loc
{
    if (!sDate || !sDate.length)
    {
        return nil;
    }
    
    NSString *dateStr = sDate;
    
    NSDate *date = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = ptn;
    dateFormatter.locale = loc;
    
    date = [dateFormatter dateFromString:dateStr];
        
    return date;
}

- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        NSLog(@"oneDay  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //刚好时间一样.
    //NSLog(@"Both dates are the same");
    return 0;
    
}

@end
