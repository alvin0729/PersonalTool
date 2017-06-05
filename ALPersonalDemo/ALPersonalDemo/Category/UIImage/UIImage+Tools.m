//
//  UIImage+Tools.m
//  CircleImage
//
//  Created by jota on 16/6/27.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)

//剪裁成圆形图片
+ (instancetype)yy_getCircleImageWithName:(UIImage *)theImage {

    UIGraphicsBeginImageContextWithOptions(theImage.size, NO, 0);
    //描述圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, theImage.size.width, theImage.size.height)];
    //设置剪裁区域
    [path addClip];
    //画图
    [theImage drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//生成不被渲染的图片
+ (instancetype)yy_getImageWithOriginalMode:(UIImage *)theImage {

    return [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

//生成中间拉伸1像素的图片
+ (instancetype)yy_getStretchImageWithName:(UIImage *)theImage {

    return [theImage stretchableImageWithLeftCapWidth:theImage.size.width * 0.5 topCapHeight:theImage.size.height * 0.5];
}

//生成抗锯齿的图片 -- 本质:生成一个透明为1的像素边框
+ (instancetype)yy_getAntialiasImageWithName:(UIImage *)theImage {
    
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border, border, theImage.size.width-2*border, theImage.size.height-2*border);
    
    UIImage *img = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [theImage drawInRect:CGRectMake(-1, -1, theImage.size.width, theImage.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(theImage.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}

@end
