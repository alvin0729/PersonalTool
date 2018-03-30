//
//  WWShapeView.m
//  Wangwang
//
//  Created by 懂懂科技 on 2018/3/1.
//  Copyright © 2018年 DDKJ. All rights reserved.
//

#import "WWShapeView.h"

@implementation WWShapeView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        ((CAShapeLayer *)self.layer).fillColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    ((CAShapeLayer *)self.layer).fillColor = [UIColor whiteColor].CGColor;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 3) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15,15)];
    ((CAShapeLayer *)self.layer).path = maskPath.CGPath;
    self.layer.masksToBounds = YES;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    ((CAShapeLayer *)self.layer).fillColor = backgroundColor.CGColor;
}

@end
