//
//  WWTagButtonTextField.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/1.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WWTagButtonTextFieldBlock)();

@interface WWTagButtonTextField : UITextField

@property(nonatomic,copy)WWTagButtonTextFieldBlock block;

@end
