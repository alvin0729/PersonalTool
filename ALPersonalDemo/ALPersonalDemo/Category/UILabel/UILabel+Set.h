//
//  UILabel+Set.h
//  DongDongWedding
//
//  Created by sunny on 16/8/31.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Set)
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;
+ (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label;
+ (CGFloat)text:(NSString*)text heightWithFont:(UIFont *)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;
@end
