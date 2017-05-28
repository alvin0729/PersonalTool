//
//  UIView+ALFrame.h
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ALFrame)

@property(nonatomic,readwrite)CGFloat viewX;
@property(nonatomic,readwrite)CGFloat viewY;
@property(nonatomic,readwrite)CGPoint viewPoint;
@property(nonatomic,readwrite)CGFloat viewWidth;
@property(nonatomic,readwrite)CGFloat viewHeight;
@property(nonatomic,readwrite)CGSize  viewSize;
@property(nonatomic,readwrite)CGFloat viewCenterX;
@property(nonatomic,readwrite)CGFloat viewCenterY;

@end
