//
//  NSObject+Base.m
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/19.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "NSObject+Base.h"
static NSMutableDictionary *modelsDescription = nil;
@implementation NSObject (Base)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modelsDescription = [NSMutableDictionary dictionary];
    });
}
- (NSString *)description {
    NSMutableString *str = [NSMutableString string];
    NSString *className = NSStringFromClass([self class]);
    NSMutableDictionary *value = modelsDescription[className];
    // 避免重复调用propertiesToDictionary
    if (value) {
        [value enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [str appendFormat:@"%@ = %@\n", key, obj];
        }];
    }else{
        
        NSDictionary *dict = [self propertiesToDictionary];
        [modelsDescription setObject: dict forKey:className] ;
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [str appendFormat:@"%@ = %@\n", key, obj];
        }];
    }
    return str;
}
- (NSMutableDictionary *)propertiesToDictionary {
    // 用以存储属性（key）及其值（value）
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    // 获取当前类对象类型
    Class cls = [self class];
    // 获取类对象的成员变量列表，ivarsCount为成员个数
    uint ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarsCount);
    // 遍历成员变量列表，其中每个变量为Ivar类型的结构体
    const Ivar *ivarsEnd = ivars + ivarsCount;
    for (const Ivar *ivarsBegin = ivars; ivarsBegin < ivarsEnd; ivarsBegin++) {
        Ivar const ivar = *ivarsBegin;
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        /*
         若此变量声明为属性，则变量名带下划线前缀'_'
         比如 @property (nonatomic, copy) NSString *name;则 key = _name;
         为方便查看属性变量，在此特殊处理掉下划线前缀
         */
        if ([key hasPrefix:@"_"]) key = [key substringFromIndex:1];
        //　获取变量值
        id value = [self valueForKey:key];
        // 处理属性未赋值属性，将其转换为null，若为nil，插入将导致程序异常
        [dictionary setObject:value ? value : [NSNull null]
                       forKey:key];
    }
    if (ivars) {
        free(ivars);
    }
    return dictionary;
}
@end
