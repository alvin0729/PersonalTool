//
//  UIImage+Exitension.h
//  DongDongWedding
//
//  Created by 谢曦 on 16/9/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface UIImage (Extension)
/** 根据原图生成一张带边框的圆图*/
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color;
//根据image返回一张模糊过的image blur 模糊度
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+ (UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
+ (UIImage *)circleImageWithColor:(UIColor *)aColor WithBounds:(CGRect)aBounds;
+ (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;
+ (UIImage*)createImageWithColor:(UIColor*) color;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;

// 常用 UIImage
+ (UIImage *)imageWithFileType:(NSString *)fileType;
+ (UIImage*)placeholderImage;
+ (UIImage *)albumsPlaceholderImage;
+ (UIImage*)leftNaviArrayImage;
+ (UIImage *)tableViewCellArrowImage;
+ (UIImage *)tableViewCellChoosedCirCleImage;
+ (UIImage *)avatarImage;

-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
-(UIImage*)scaledToMaxSize:(CGSize )size;

/** 带依据配置压缩图片*/
- (void)saveImageToSandBoxWithImageName:(NSString*)name;
/** 无压缩保存到一个完整路径.*/
- (BOOL)saveImageToFullPath:(NSString*)filePath;

+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;
@end
