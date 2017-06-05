//
//  UIImageView+CircleImage.m
//  CircleImage
//
//  Created by jota on 16/6/27.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "UIImageView+CircleImage.h"
#import "UIImage+Tools.h"
//#import "SDWebImage/UIImageView+WebCache.h"

@implementation UIImageView (CircleImage)

//生成圆形图片
- (void)yy_setCircleImageWithURL:(NSString *)urlString {
    
//    [self sd_setImageWithURL:[NSURL URLWithString:urlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image == nil) {
//            return;
//        }
//        self.image = [UIImage yy_getCircleImageWithName:image];
//    }];
}

//生成方形图片
- (void)yy_setDefalutImageWithURL:(NSString *)urlString {
    
    //[self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil];
}

@end
