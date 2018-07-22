//
//  UIImage+TY_Size.m
//  TYFoundationDemo
//
//  Created by tanyang on 15/12/9.
//  Copyright © 2015年 tanyang. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (TY_Size)

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

- (UIImage *)imageCroppedToRect:(CGRect)rect
{
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    //draw
    [self drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)imageScaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(self.size, size))
    {
        return self;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)imageScaledToFitSize:(CGSize)size
{
    //calculate rect
    CGFloat aspect = self.size.width / self.size.height;
    if (size.width / aspect <= size.height)
    {
        return [self imageScaledToSize:CGSizeMake(size.width, size.width / aspect)];
    }
    else
    {
        return [self imageScaledToSize:CGSizeMake(size.height * aspect, size.height)];
    }
}

- (UIImage *)imageScaledToFillSize:(CGSize)size
{
    if (CGSizeEqualToSize(self.size, size))
    {
        return self;
    }
    //calculate rect
    CGFloat aspect = self.size.width / self.size.height;
    if (size.width / aspect >= size.height)
    {
        return [self imageScaledToSize:CGSizeMake(size.width, size.width / aspect)];
    }
    else
    {
        return [self imageScaledToSize:CGSizeMake(size.height * aspect, size.height)];
    }
}

- (UIImage *)imageCroppedAndScaledToSize:(CGSize)size
                             contentMode:(UIViewContentMode)contentMode
                                padToFit:(BOOL)padToFit;
{
    //calculate rect
    CGRect rect = CGRectZero;
    switch (contentMode)
    {
        case UIViewContentModeScaleAspectFit:
        {
            CGFloat aspect = self.size.width / self.size.height;
            if (size.width / aspect <= size.height)
            {
                rect = CGRectMake(0.0f, (size.height - size.width / aspect) / 2.0f, size.width, size.width / aspect);
            }
            else
            {
                rect = CGRectMake((size.width - size.height * aspect) / 2.0f, 0.0f, size.height * aspect, size.height);
            }
            break;
        }
        case UIViewContentModeScaleAspectFill:
        {
            CGFloat aspect = self.size.width / self.size.height;
            if (size.width / aspect >= size.height)
            {
                rect = CGRectMake(0.0f, (size.height - size.width / aspect) / 2.0f, size.width, size.width / aspect);
            }
            else
            {
                rect = CGRectMake((size.width - size.height * aspect) / 2.0f, 0.0f, size.height * aspect, size.height);
            }
            break;
        }
        case UIViewContentModeCenter:
        {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeTop:
        {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, 0.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeBottom:
        {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeLeft:
        {
            rect = CGRectMake(0.0f, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeRight:
        {
            rect = CGRectMake(size.width - self.size.width, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeTopLeft:
        {
            rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeTopRight:
        {
            rect = CGRectMake(size.width - self.size.width, 0.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeBottomLeft:
        {
            rect = CGRectMake(0.0f, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeBottomRight:
        {
            rect = CGRectMake(size.width - self.size.width, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
        default:
        {
            rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
            break;
        }
    }
    
    if (!padToFit)
    {
        //remove padding
        if (rect.size.width < size.width)
        {
            size.width = rect.size.width;
            rect.origin.x = 0.0f;
        }
        if (rect.size.height < size.height)
        {
            size.height = rect.size.height;
            rect.origin.y = 0.0f;
        }
    }
    
    //avoid redundant drawing
    if (CGSizeEqualToSize(self.size, size))
    {
        return self;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [self drawInRect:rect];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

@end


//+ (NSData *)compressImageLessThanMaxMemory:(NSInteger)maxMemory andData:(NSData *)originalData
//{
//
//    NSData *imgData = originalData;
//    unsigned long inlength = imgData.length;
//    NSLog(@"size before compress:%lu", inlength);
//
//    if (imgData.length > (maxMemory*1024)) {
//        UIImage *image = [UIImage imageWithData:imgData];
//
//        // aimWidth == 0时不做图片分辨率压缩
//        imgData = [self compressImageWithImage:image aimWidth:0 aimLength:maxMemory*1024 accuracyOfLength:1024];
//    }
//
//    inlength = imgData.length;
//    NSLog(@"size after compress:%lu", inlength);
//
//    return imgData;
//
//}
//
//
///**
// 二分法压缩图片体积;
// */
//+ (NSData *)compressImageWithImage:(UIImage *)image aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy
//{
//
//    UIImage * newImage;
//    if (width == 0) {
//        newImage = image;
//    } else {
//        newImage = [self imageWithImage:image scaledToSize:CGSizeMake(width, width * image.size.height / image.size.width)];
//    }
//
//    NSData  * data = UIImageJPEGRepresentation(newImage, 1);
//    NSInteger imageDataLen = [data length];
//
//    if (imageDataLen <= length + accuracy) {
//        return data;
//    }else{
//        NSData * imageData = UIImageJPEGRepresentation( newImage, 0.99);
//        if (imageData.length < length + accuracy) {
//            return imageData;
//        }
//
//        CGFloat maxQuality = 1.0;
//        CGFloat minQuality = 0.0;
//        int flag = 0;
//
//        while (1) {
//            CGFloat midQuality = (maxQuality + minQuality)/2;
//
//            if (flag == 6) {
//                NSLog(@"************* %ld ******** %f *************",UIImageJPEGRepresentation(newImage, minQuality).length,minQuality);
//                return UIImageJPEGRepresentation(newImage, minQuality);
//            }
//            flag ++;
//
//            NSData * imageData = UIImageJPEGRepresentation(newImage, midQuality);
//            NSInteger len = imageData.length;
//
//            if (len > length+accuracy) {
//                NSLog(@"-----%d------%f------%ld-----",flag,midQuality,len);
//                maxQuality = midQuality;
//                continue;
//            }else if (len < length-accuracy){
//                NSLog(@"-----%d------%f------%ld-----",flag,midQuality,len);
//                minQuality = midQuality;
//                continue;
//            }else{
//                NSLog(@"-----%d------%f------%ld--end",flag,midQuality,len);
//                return imageData;
//                break;
//            }
//        }
//    }
//}
//
////对图片尺寸进行压缩,图片分辨率压缩;
//+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//    UIGraphicsBeginImageContext(newSize);
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}
//
//
//+ (void)savePublishPics:(NSMutableArray*)picsArray;
//{
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:0];
//        for (UIImage *image in picsArray) {
//
//            NSData *data = UIImageJPEGRepresentation(image, 1);
//            [tempArray addObject:data];
//
//        }
//
//        [ND setObject:tempArray forKey:SavePics];
//
//    });
//
//}
//
///**
// 计算文字字符个数:
//
// @param string 字符串
// @return 字符数量
// */
//+ (NSInteger)lenghtWithString:(NSString *)string;
//{
//
//    NSUInteger len = string.length;
//    // 汉字字符集
//    NSString * pattern  = @"[\u4e00-\u9fa5]";
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
//    // 计算中文字符的个数
//    NSInteger numMatch = [regex numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, len)];
//
//    return len + numMatch;
//
//}

