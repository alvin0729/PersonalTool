//
//  ALWindowTapObserver.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/11/1.
//  Copyright © 2017年 company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ALWindowTapObserver : NSObject

/**
 Returns the default singleton instance.
 */
+ (nonnull instancetype)sharedManager;

-(void)addObserverTouchView:(nullable UIView *)view withBlock:(nullable dispatch_block_t)block;

@end
