//
//  HHTextAttachment.h
//  wwrj
//
//  Created by wwrj on 16/12/14.
//  Copyright © 2016年 wwrj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HHImageStyle.h"
@interface HHTextAttachment : NSTextAttachment


+ (instancetype)attachmentWithImage:(UIImage *)image width:(CGFloat)width;

@property (nonatomic, strong) HHImageStyle *imageStyle;
@end
