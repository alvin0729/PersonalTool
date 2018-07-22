//
//  UIView+category.h
//  iLearning
//
//  Created by Sidney on 13-9-4.
//  Copyright (c) 2013年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Extension)

- (void)addTarget:(id)target action:(SEL)action;

- (BOOL)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename;
//- (UIImage *)viewToImage:(UIWebView*)webView;

//－－－－－－－－－－ frame－－－－－－－－－－－－－－－
@property CGPoint aOrigin;//获得视图的起点坐标
@property CGSize aSize;//获得视图的宽和高

@property (readonly) CGPoint aBottomLeft;
@property (readonly) CGPoint aBottomRight;
@property (readonly) CGPoint aTopRight;

@property CGFloat aHeight;//获得视图的高
@property CGFloat aWidth;//获得视图的宽

@property CGFloat aTop;//获得视图的顶部y
@property CGFloat aLeft;//获得视图的左部x

@property CGFloat aBottom;//获得视图的底部y
@property CGFloat aRight;//获得视图的右部x

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

-(UIViewController *)viewController;//------------事件效应者-----------
+ (UIView *)returnViewFrame:(CGRect)aFrame;
+ (void)keyendEditing;

- (void)showShockHUD:(UIView*)hudView
            duration:(NSTimeInterval)duration
          moveVector:(CGPoint)moveVector
          completion:(void (^)(BOOL))completion;

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
          moveVector:(CGPoint)moveVector;

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options
          moveVector:(CGPoint)moveVector
          completion:(void (^)(BOOL))completion;

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options
          animations:(void (^)(void))animations
          completion:(void (^)(BOOL))completion;

@end
