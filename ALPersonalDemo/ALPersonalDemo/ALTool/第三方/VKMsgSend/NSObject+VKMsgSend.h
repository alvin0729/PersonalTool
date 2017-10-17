//
//  NSObject+idSelectorCall.h
//  IdSelectorCall
//
//  Created by Awhisper on 15/12/25.
//  Copyright © 2015年 Awhisper. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (VKMsgSend)

+ (id)VKCallSelector:(SEL)selector error:(NSError *__autoreleasing *)error,...;

+ (id)VKCallSelectorName:(NSString *)selName error:(NSError *__autoreleasing *)error,...;

- (id)VKCallSelector:(SEL)selector error:(NSError *__autoreleasing *)error,...;

- (id)VKCallSelectorName:(NSString *)selName error:(NSError *__autoreleasing *)error,...;

@end
