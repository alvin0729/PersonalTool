//
//  UIImage+fixOrientation.h
//  CountyHospital2
//
//  Created by melp on 13-12-22.
//  Copyright (c) 2013年 pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

- (UIImage *)fixOrientation;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
/**
 *  将颜色转换为图片
 *
 *  @param color 颜色值
 *
 *  @return 转换后的图片
 */
+ (UIImage *) createImageWithColor: (UIColor*) color;
@end
