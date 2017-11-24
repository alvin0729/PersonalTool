//
//  UIView+BNBoom.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/11/21.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BNBoom)

@property (nonatomic, strong) NSMutableArray <CALayer *> *boomCells;
@property (nonatomic, strong) UIImage *scaleSnapshot;

- (void)boom;
- (void)reset;

@end

@interface UIImage (BNBoom)

- (UIImage *)scaleImageToSize:(CGSize)size;

@end
