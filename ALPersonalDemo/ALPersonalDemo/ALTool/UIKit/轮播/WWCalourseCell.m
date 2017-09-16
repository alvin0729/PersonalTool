//
//  WWCalourseCell.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/8/22.
//  Copyright © 2017年 company. All rights reserved.
//

#import "WWCalourseCell.h"

@implementation WWCalourseCell

-(instancetype)init
{
    if (self = [super init]) {
        UIImageView* imageView=[[UIImageView alloc]init];
        [imageView.layer setCornerRadius:6.0f];
        [imageView.layer setMasksToBounds:YES];
        [self addSubview:imageView];
        _imageView=imageView;
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [_imageView setFrame:self.bounds];
}

@end
