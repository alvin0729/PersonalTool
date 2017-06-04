//
//  NSString+extension.m
//  DongDongWedding
//
//  Created by 谢曦 on 2016/11/10.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "NSString+extension.h"

@implementation NSString (extension)
+(NSString *)timeStrFromTimeStamp:(NSString *)timeStamp
{
   
    NSTimeInterval time=[timeStamp doubleValue];
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];

     NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
      [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
   return  [dateFormatter stringFromDate:detaildate];

}
+(NSString *)timeDateStrFromTimeStamp:(NSString *)timeStamp
{
    
    NSTimeInterval time=[timeStamp doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return  [dateFormatter stringFromDate:detaildate];
    
}
+(NSString *)stampFromTimeStr:(NSString *)timeStr

{
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //str -->  date
    NSDate*inputDate = [inputFormatter dateFromString:timeStr];
    
   return  [NSString stampFromTimeDate:inputDate];
    

}
+(NSString *)stampFromTimeDate:(NSDate *)time

{
    NSString *stampStr = [NSString stringWithFormat:@"%ld", (long)[time timeIntervalSince1970]];

    return stampStr;
}


#pragma mark - base64Code
+(NSString *)Base64CodeWithStr:(NSString *)str
{
    NSData *nsdata = [str
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    //加密
    
    return base64Encoded;
    
    //解密
    //        NSData *nsdataFromBase64String = [[NSData alloc]
    //                                      initWithBase64EncodedString:base64Encoded options:0];
    //
    //    NSString *base64Decoded = [[NSString alloc]
    //                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
- (BOOL) isBlankString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
