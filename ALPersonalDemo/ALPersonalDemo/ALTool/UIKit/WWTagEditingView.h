//
//  WWTagEditingView.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/1.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWTagButtonTextField.h"



@interface WWTagEditingView : UIView

@property(nonatomic,strong)WWTagButtonTextField *textField;


@property(nonatomic,strong)NSMutableArray*btnArray;

@property(nonatomic,strong)UIButton* assBtn;

-(void)creatBtnWithTitle:(NSString*)btnTitle;

@end
