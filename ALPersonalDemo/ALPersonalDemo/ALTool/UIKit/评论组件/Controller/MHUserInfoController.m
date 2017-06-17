//
//  MHUserInfoController.m
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/9.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHUserInfoController.h"
#import "MHUser.h"
#import "UIView+ALFrame.h"
#import "MHWebImageTool.h"
#import "MHConstant.h"

@interface MHUserInfoController ()

@end

@implementation MHUserInfoController

- (void)dealloc
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化
    [self _setup];
    
    // 设置导航栏
    [self _setupNavigationItem];
    
    // 设置子控件
    [self _setupSubViews];
    
    // 监听通知中心
    [self _addNotificationCenter];
}
#pragma mark - 公共方法


#pragma mark - 私有方法

#pragma mark - 初始化
- (void)_setup
{
    
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem
{
    self.title = [NSString stringWithFormat:@"%@个人信息",self.user.nickname];
}

#pragma mark - 设置子控件
- (void)_setupSubViews
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.viewSize = CGSizeMake(268.0f, 271.0f);
    imageView.viewCenterX = self.view.viewCenterX;
    imageView.viewCenterY = self.view.viewCenterY;
    [self.view addSubview:imageView];
    
    [MHWebImageTool setImageWithURL:self.user.avatarUrl placeholderImage:MHGlobalUserDefaultAvatar imageView:imageView];
    
}

#pragma mark - 添加通知中心
- (void)_addNotificationCenter
{
    
}


@end
