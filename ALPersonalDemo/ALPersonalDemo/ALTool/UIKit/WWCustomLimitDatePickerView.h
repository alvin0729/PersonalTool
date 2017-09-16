//
//  WWCustomLimitDatePickerView.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/8/16.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WWCustomLimitDatePickerDelegate <NSObject>
@optional
//选中日期
-(void)didSelectedDateString:(NSString *)dateString;
//取消日期
-(void)cancelDatePicker;
@end


@interface WWCustomLimitDatePickerView : UIView

//代理
@property (nonatomic ,weak)id<WWCustomLimitDatePickerDelegate>delegate;

@property(nonatomic,strong) UIView * topView;

@property(nonatomic,copy) void (^LimitDatePickerDidSelectedDateString)(NSString *dateString);

+ (instancetype)initCustomLimitDatePicker;
/*  设置Picker显示 最小-最大范围  默认范围为:1960-01-01 2300:12:31
 *  maxString 最大时间
 *  minString 最小时间
 *  dateStringBlock 选择日期回调
 */
- (void)showWithMaxDateString:(NSString *)maxString withMinDateString:(NSString *)minString didSeletedDateStringBlock:(void (^)(NSString *dateString))dateStringBlock;
@end
