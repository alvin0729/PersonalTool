//
//  UIImage+Tools.h
//  CircleImage
//
//  Created by jota on 16/6/27.
//  Copyright © 2016年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)

//剪裁成圆形图片
+ (instancetype)yy_getCircleImageWithName:(UIImage *)theImage;
//生成不被渲染的图片
+ (instancetype)yy_getImageWithOriginalMode:(UIImage *)theImage;
//生成中间拉伸1像素的图片
+ (instancetype)yy_getStretchImageWithName:(UIImage *)theImage;
//生成抗锯齿的图片 -- 本质:生成一个透明为1的像素边框
+ (instancetype)yy_getAntialiasImageWithName:(UIImage *)theImage;

@end
