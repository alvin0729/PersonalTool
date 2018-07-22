//
//  NSData-AES.m
//  Encryption
//
//  Created by Jeff LaMarche on 2/12/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData(AES)

- (NSData *)AES128EncryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused) // oorspronkelijk 256
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES256, // oorspronkelijk 256
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

//- (NSData *)createData:(NSString *)key {
- (NSData *)AES128EncryptWithKey:(NSString *)key length:(NSInteger)length {
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused) // oorspronkelijk 256
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [self length];
	
	//See the doc: For block ciphers, the output size will always be less than or 
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
    size_t bufferSize = length + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
    void *inbuffer = malloc(bufferSize);
    memset(inbuffer, 0, bufferSize);
    memccpy(inbuffer, [self bytes], 0, dataLength);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionECBMode, //kCCOptionPKCS7Padding | kCCOptionECBMode,
										  keyPtr, kCCKeySizeAES256, // oorspronkelijk 256
										  NULL /* initialization vector (optional) */,
										  inbuffer, length, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesEncrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
	
	free(buffer); //free the buffer;
	return nil;
}

// AES128 解密
//- (NSData *)newData:(NSString *)key {
- (NSData *)AES128DecryptWithKey:(NSString *)key {
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused) // oorspronkelijk 256
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [self length];
	
	//See the doc: For block ciphers, the output size will always be less than or 
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionECBMode, //kCCOptionPKCS7Padding | kCCOptionECBMode,
										  keyPtr, kCCKeySizeAES128, // oorspronkelijk 256
										  NULL /* initialization vector (optional) */,
										  [self bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	}
	
	free(buffer); //free the buffer;
	return nil;
}

#pragma mark -
#pragma mark functions for debug purpose

- (NSString*)hexDump
{
    unsigned char *inbuf = (unsigned char *)[self bytes];	
	NSMutableString* stringBuffer = [NSMutableString string];
    for (int i=0; i<[self length]; i++)
    {
        if (i != 0 && i % 16 == 0)
			[stringBuffer appendString:@"\n"];
		[stringBuffer appendFormat:@"0x%02X, ", inbuf[i]];
    }
	return stringBuffer;
}

- (NSString *)hexToStr
{
    unsigned char *inbuf = (unsigned char *)[self bytes];
	NSMutableString* stringBuffer = [NSMutableString string];
    for (int i=0; i<[self length]; i++)
    {
		[stringBuffer appendFormat:@"%02X", inbuf[i]];
    }
	return stringBuffer;
}

@end
