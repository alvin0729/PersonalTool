//
//  WWDropDownMenu.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/7/20.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWDropDownMenu;
@protocol WWDropdownMenuDelegate <NSObject>

@optional

- (void)dropdownMenuDidHidden:(WWDropDownMenu *)menu mainBtnTitle:(NSString *)title;   // 当下拉菜单已经收起时调用

@end

@interface WWDropDownMenu : UIView

@property (nonatomic,strong) UIButton * mainBtn;

@property (nonatomic, assign) id <WWDropdownMenuDelegate>delegate;


- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight;  // 设置下拉菜单控件样式

- (void)showDropDown; // 显示下拉菜单
- (void)hideDropDown; // 隐藏下拉菜单
@end
