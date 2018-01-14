//
//  PMainThreadWatcher.h
//  UIThreadWatcher
//https://mp.weixin.qq.com/s?__biz=MzI5MjEzNzA1MA==&mid=2650264136&idx=1&sn=052c1db8131d4bed8458b98e1ec0d5b0&chksm=f406837dc3710a6b49e76ce3639f671373b553e8a91b544e82bb8747e9adc7985fea1093a394#rd
//  Created by gao feng on 2016/10/8.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMainThreadWatcherDelegate <NSObject>

- (void)onMainThreadSlowStackDetected:(NSArray*)slowStack;

@end

@interface PMainThreadWatcher : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<PMainThreadWatcherDelegate>     watchDelegate;


//must be called from main thread
- (void)startWatch;

@end
