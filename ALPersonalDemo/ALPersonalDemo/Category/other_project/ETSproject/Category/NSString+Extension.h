//
//  NSString+BXExtension.h
//  BXInsurenceBroker
//
//  Created by JYJ on 16/2/23.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *手机号码验证 MODIFIED BY HELENSONG
 */
- (BOOL) isValidateMobile;
///**
// *身份证验证
// */
//- (BOOL)validateIdentityCard;
/**
 * 判断字段是否包含空格
 */
- (BOOL)validateContainsSpace;

/**
 *  根据生日返回年龄
 */
- (NSString *)ageFromBirthday;

/**
 *  根据身份证返回岁数
 */
- (NSString *)ageFromIDCard;

/**
 *  根据身份证返回生日
 */
- (NSString*)birthdayFromIDCard;

/**
 *  根据身份证返回性别
 */
- (NSString*)sexFromIDCard;

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

+ (NSString *)stringWithMoneyAmount:(double)amount;

+ (NSString *)stringIntervalFrom:(NSDate *)start to:(NSDate *)end;

//邮箱
+ (BOOL)validateEmail:(NSString *)email;

- (BOOL)isEmptyString;


/* NSArray or NSDitionary to JsonString */
+ (NSString *)objectTojsonString:(id)object;
+ (id)jsonStringToObject:(NSString *)jsonString;




/*字符加换行符号\n*/
- (NSString *)appNextLineKeyword:(NSString *)word;


/*获取字符串的长度*/
- (CGSize)getSizeOfStringFontSize:(int)fontSize constroSize:(CGSize)size;
- (CGSize)getSizeOfString:(UIFont *)font constroSize:(CGSize)size;

/*邮箱验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateEmail;
/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateCarNo;

/*用户名验证*/
- (BOOL)isValidateUserName;

/*密码验证*/
- (BOOL)isValidatePassword;

/*昵称验证*/
- (BOOL)isValidateNickname;

/*学员号验证*/
- (BOOL)isValidateCode;

/*个性签名验证*/
- (BOOL)isValidateSign;

//获取当前的时间字符串
+ (NSString *)getCurrentDateString;

+ (NSString *)getTimerIntervalSince1970;

//NSDate 转 NSString yyyy-MM-dd
+ (NSString *)dateToStringYYYMMDD:(NSDate *)date;
//yyyy-MM-dd HH:mm
+ (NSString *)dateToStringYYYMMDDHHMM:(NSDate *)date;

+ (NSString *)dateToStringHHMM:(NSDate *)date;
//汉字编码
-(NSString *)URLEncodedStringbj;

+ (NSString *)dateToStringHHMMSS:(NSDate *)date;

//U2获取guid
+ (NSString *)getUniqueStrByUUID;




/**
 ****************************（MD5）**************************
 */


/*字符串转 MD5*/
- (NSString *)stringFromMD5;
/*字符串转 sha1*/
- (NSString *)sha1;


/**
 ****************************（Base64+DES）**************************
 */

/**
 加密：先进行DES加密，然后再base64，返回NSString
 */
+ (NSString *)encode:(NSString *)text;

/**
 解密：先解base64，再解DES
 */
+ (NSString *)decode:(NSString *)text;


///**
// DES加密，秘钥已经指定
// */
//+ (NSString *)DESEncrypt:(NSString *)text;
//
///**
// DES解密，秘钥已经指定
// */
//+ (NSString *)DESDecrypt:(NSString *)text;


/**
 base64加密
 */
+ (NSString *)base64StringFromText:(NSString *)text;

/**
 base64解密
 */
+ (NSString *)textFromBase64String:(NSString *)base64;


//获取URL参数字典
- (NSMutableDictionary *)getURLParameters;

//判断url地址是否包含http或https
- (NSString *)checkeUrlString;


@end
