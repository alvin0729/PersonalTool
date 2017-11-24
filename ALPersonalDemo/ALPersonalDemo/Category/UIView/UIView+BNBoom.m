//
//  UIView+BNBoom.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/11/21.
//  Copyright © 2017年 company. All rights reserved.
//

#import "UIView+BNBoom.h"
#import <objc/runtime.h>
#include <stdlib.h>

static const void *BoomCellsName = &BoomCellsName;
static const void *ScaleSnapshotName = &ScaleSnapshotName;

@implementation UIView (BNBoom)

//MARK: - 生命周期相关，在从父View移除的时候释放粒子
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [super class];
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(willMoveToSuperview:);
        SEL swizzledSelector = @selector(BN_willMoveToSuperview:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)BN_willMoveToSuperview:(UIView *)superView {
    [self removeBoomCells];
    
    [self BN_willMoveToSuperview:superView];
}

- (void)setBoomCells:(NSMutableArray <CALayer *> *)boomCells {
    objc_setAssociatedObject(self, BoomCellsName, boomCells, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray <CALayer *> *)boomCells {
    NSMutableArray <CALayer *> *cells = objc_getAssociatedObject(self, BoomCellsName);
    
    return cells;
}

- (void)setScaleSnapshot:(UIImage *)snapshot {
    objc_setAssociatedObject(self, ScaleSnapshotName, snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)scaleSnapshot {
    UIImage *snapshot = objc_getAssociatedObject(self, ScaleSnapshotName);
    
    return snapshot;
}

- (void)scaleOpacityAnimations {
    //缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.01];
    scaleAnimation.duration = 0.15;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    //透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0];
    opacityAnimation.duration = 0.15;
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    //
    [self.layer addAnimation:scaleAnimation forKey:@"lscale"];
    [self.layer addAnimation:opacityAnimation forKey:@"lopacity"];
    self.layer.opacity = 0;
}

- (void)cellAnimations {
    for (CALayer *shape in self.boomCells) {
        shape.position = self.center;
        shape.opacity = 1;
        //路径
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnimation.path = [self makeRandomPath:shape].CGPath;
        moveAnimation.removedOnCompletion = FALSE;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.240000 :0.590000 :0.506667 :0.026667];
        moveAnimation.duration = ((NSTimeInterval)(arc4random()%10)) * 0.05 + 0.3;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.toValue = [self makeScaleValue];
        scaleAnimation.duration = moveAnimation.duration;
        scaleAnimation.removedOnCompletion = FALSE;
        scaleAnimation.fillMode = kCAFillModeForwards;
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0];
        opacityAnimation.duration = moveAnimation.duration;
        //            opacityAnimation.delegate = self
        opacityAnimation.removedOnCompletion = TRUE;
        opacityAnimation.fillMode = kCAFillModeForwards;
        opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.380000 :0.033333 :0.963333 :0.260000];
        
        shape.opacity = 0;
        [shape addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [shape addAnimation:moveAnimation forKey:@"moveAnimation"];
        [shape addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    }
}

//随机产生震动值
- (NSNumber *)makeShakeValue:(CGFloat)offset {
    CGFloat basicOrigin = -10;
    CGFloat maxOffset = -2 * basicOrigin;
    return [NSNumber numberWithFloat:(basicOrigin + maxOffset * ((float)(arc4random()%101)/100) + offset)];
}

//随机产生缩放数值
- (NSNumber *)makeScaleValue {
    return [NSNumber numberWithFloat:(1 - 0.7 * ((float)((arc4random() % 51))/50))];
}

//随机产生粒子路径
- (UIBezierPath *)makeRandomPath:(CALayer *)subLayer {
    UIBezierPath *particlePath = [UIBezierPath bezierPath];
    [particlePath moveToPoint:self.layer.position];
    CGFloat basicLeft = - 1.3 * self.layer.frame.size.width;
    CGFloat maxOffset = 2 * fabs(basicLeft);
    CGFloat randomNumber = arc4random()%101;
    CGFloat endPointX = basicLeft + maxOffset * (((float)randomNumber)/100) + subLayer.position.x;
    CGFloat controlPointOffSetX = (endPointX - subLayer.position.x)/2  + subLayer.position.x;
    CGFloat controlPointOffSetY = self.layer.position.y - 0.2 * self.layer.frame.size.height - (float)(arc4random() % (int)(1.2 * self.layer.frame.size.height));
    CGFloat endPointY = self.layer.position.y + self.layer.frame.size.height/2 + (float)(arc4random() % (int)(self.layer.frame.size.height/2));
    [particlePath addQuadCurveToPoint:CGPointMake(endPointX, endPointY) controlPoint:CGPointMake(controlPointOffSetX, controlPointOffSetY)];
    return particlePath;
}

//移除粒子
- (void)removeBoomCells {
    if (self.boomCells.count == 0) {
        return;
    }
    
    for (CALayer *subLayer in self.boomCells) {
        [subLayer removeFromSuperlayer];
    }
    
    self.boomCells = nil;
}

//MARK: - 公开方法
//从layer获取View的截图
- (UIImage *)snapshot {
    UIGraphicsBeginImageContext(self.layer.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

- (void)boom {
    //摇摆~ 摇摆~ 震动~ 震动~
    CAKeyframeAnimation *shakeXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    shakeXAnimation.duration = 0.2;
    shakeXAnimation.values = @[[self makeShakeValue:self.layer.position.x],
                               [self makeShakeValue:self.layer.position.x],
                               [self makeShakeValue:self.layer.position.x],
                               [self makeShakeValue:self.layer.position.x],
                               [self makeShakeValue:self.layer.position.x]];
    CAKeyframeAnimation *shakeYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    shakeYAnimation.duration = shakeXAnimation.duration;
    shakeYAnimation.values = @[[self makeShakeValue:self.layer.position.y],
                               [self makeShakeValue:self.layer.position.y],
                               [self makeShakeValue:self.layer.position.y],
                               [self makeShakeValue:self.layer.position.y],
                               [self makeShakeValue:self.layer.position.y]];
    
    [self.layer addAnimation:shakeXAnimation forKey:@"shakeXAnimation"];
    [self.layer addAnimation:shakeYAnimation forKey:@"shakeYAnimation"];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(scaleOpacityAnimations) userInfo:nil repeats:FALSE];
    
    if (self.boomCells.count == 0) {
        NSMutableArray *cellsToSet = [NSMutableArray array];
        
        if (!self.scaleSnapshot) {
            self.scaleSnapshot = [[self snapshot] scaleImageToSize:CGSizeMake(34, 34)];
        }
        
        CGImageRef imageRef = [[self scaleSnapshot] CGImage];
        NSUInteger imageW = CGImageGetWidth(imageRef);
        NSUInteger imageH = CGImageGetHeight(imageRef);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        NSUInteger bytesPerPixel = 4; //一个像素4字节
        NSUInteger bytesPerRow = bytesPerPixel * imageW;
        unsigned char *rawData = (unsigned char*)calloc(imageH*imageW*bytesPerPixel, sizeof(unsigned char)); //元数据
        NSUInteger bitsPerComponent = 8;
        CGContextRef context = CGBitmapContextCreate(rawData, imageW, imageH, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
        CGColorSpaceRelease(colorSpace);
        CGContextDrawImage(context, CGRectMake(0, 0, imageW, imageH), imageRef);
        CGContextRelease(context);
        
        for (int i = 0; i < 17; i++) {
            for (int j = 0; j < 17; j++) {
                CGFloat pWidth = ((CGFloat)MIN(self.frame.size.width, self.frame.size.height))/17;
                
                unsigned long pixelInfo = ((imageW * j * 2) + i * 2) * 4;
                CGFloat r = rawData[pixelInfo] / 255.0;
                CGFloat g= rawData[pixelInfo+1] / 255.0;
                CGFloat b = rawData[pixelInfo+2] / 255.0;
                CGFloat a = rawData[pixelInfo+3] / 255.0;
                UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
                
                CALayer *shape = [CALayer new];
                shape.backgroundColor = color.CGColor;
                shape.opacity = 0;
                shape.cornerRadius = pWidth/2;
                shape.frame = CGRectMake(i * pWidth, j * pWidth, pWidth, pWidth);
                [self.layer.superlayer addSublayer:shape];
                
                [cellsToSet addObject:shape];
            }
        }
        
        free(rawData);
        
        self.boomCells = cellsToSet;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(cellAnimations) userInfo:nil repeats:FALSE];
}

- (void)reset {
    self.layer.opacity = 1;
}

@end

@implementation UIImage (BNBoom)

//static const void *RGBBitmapContextName = &RGBBitmapContextName;
//
//- (void)setRgbBitmapContext:(CGContextRef)rgbBitmapContext {
//    objc_setAssociatedObject(self, RGBBitmapContextName, (__bridge id)(rgbBitmapContext), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (CGContextRef)rgbBitmapContext {
//    CGContextRef context = (__bridge CGContextRef)(objc_getAssociatedObject(self, RGBBitmapContextName));
//
//    return context;
//}
//
//- (CGContextRef)createARGBBitmapContextFromImage {
//    if (self.rgbBitmapContext != nil) {
//        return self.rgbBitmapContext;
//    } else {
//        CGImageRef imageRef = self.CGImage;
//        NSUInteger imageW = CGImageGetWidth(imageRef);
//        NSUInteger imageH = CGImageGetHeight(imageRef);
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        NSUInteger bytesPerPixel = 4; //一个像素4字节
//        NSUInteger bytesPerRow = bytesPerPixel * imageW;
//        unsigned char *rawData = (unsigned char*)calloc(imageH*imageW*bytesPerPixel, sizeof(unsigned char)); //元数据
//        NSUInteger bitsPerComponent = 8;
//        CGContextRef context = CGBitmapContextCreate(rawData, imageW, imageH, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
//        CGColorSpaceRelease(colorSpace);
//        CGContextDrawImage(context, CGRectMake(0, 0, imageW, imageH), imageRef);
//
//        free(rawData);
//
//        self.rgbBitmapContext = context;
//        return context;
//    }
//}
//
//- (UIColor *)getPixelColorAtLocation:(CGPoint)point {
//    CGImageRef imageRef = [self CGImage];
//    NSUInteger imageW = CGImageGetWidth(imageRef);
//    NSUInteger imageH = CGImageGetHeight(imageRef);
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    NSUInteger bytesPerPixel = 4; //一个像素4字节
//    NSUInteger bytesPerRow = bytesPerPixel * imageW;
//    unsigned char *rawData = (unsigned char*)calloc(imageH*imageW*bytesPerPixel, sizeof(unsigned char)); //元数据
//    NSUInteger bitsPerComponent = 8;
//    CGContextRef context = CGBitmapContextCreate(rawData, imageW, imageH, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
//    CGColorSpaceRelease(colorSpace);
//    CGContextDrawImage(context, CGRectMake(0, 0, imageW, imageH), imageRef);
//    CGContextRelease(context);
//
//    int pixelInfo = ((imageW * point.y) + point.x) * 4;
//
//    CGFloat r = rawData[pixelInfo] / 255.0;
//    CGFloat g = rawData[pixelInfo+1] / 255.0;
//    CGFloat b = rawData[pixelInfo+2] / 255.0;
//    CGFloat a = rawData[pixelInfo+3] / 255.0;
//
//    free(rawData);
//
//    return [UIColor colorWithRed:r green:g blue:b alpha:a];
//}

//缩放图片
- (UIImage *)scaleImageToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end

