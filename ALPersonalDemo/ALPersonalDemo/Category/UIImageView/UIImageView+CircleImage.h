//
//  UIImageView+CircleImage.h
//  CircleImage
//
//  Created by jota on 16/6/27.
//  Copyright © 2016年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CircleImage)

//生成圆形图片
- (void)yy_setCircleImageWithURL:(NSString *)urlString;

//生成方形图片
- (void)yy_setDefalutImageWithURL:(NSString *)urlString;

@end
