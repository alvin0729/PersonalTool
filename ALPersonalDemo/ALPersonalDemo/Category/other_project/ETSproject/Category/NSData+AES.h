//
//  NSData-AES.h
//  Encryption
//
//  Created by Jeff LaMarche on 2/12/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(AES)
- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData *)AES128EncryptWithKey:(NSString *)key length:(NSInteger)length;
//- (NSData *)createData:(NSString *)key;
// 为了混淆视听，避免从函数名猜到算法
//- (NSData *)newData:(NSString *)key;
- (NSData *)AES128DecryptWithKey:(NSString *)key;
- (NSString *)hexDump;
- (NSString *)hexToStr;
@end
