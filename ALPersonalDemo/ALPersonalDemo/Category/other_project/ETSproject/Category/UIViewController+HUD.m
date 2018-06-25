/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIViewController+HUD.h"
#import <objc/runtime.h>
//#import <JGProgressHUD.h>

@implementation UIViewController (HUD)
//- (void)showHudInView:(UIView *)view hint:(NSString *)hint
//{
//    [self hideHud];
//
//    UIView *loadView1 = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT)];
//    loadView1.backgroundColor = [UIColor clearColor];
//    loadView1.tag = 98765;
//    [view addSubview:loadView1];
//    [view bringSubviewToFront:loadView1];
//
//    UIView *loadView2 = [[UIView alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-120, NAV_BAR_HEIGHT)];
//    loadView2.backgroundColor = [UIColor clearColor];
//    loadView2.tag = 987654;
//    [view addSubview:loadView2];
//    [view bringSubviewToFront:loadView2];
//
//    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
//    HUD.tag = 9902;
//    HUD.position = JGProgressHUDPositionCenter;
//    HUD.userInteractionEnabled = YES;
//    if(hint && hint.length){
//        HUD.textLabel.text = hint;
//    }
//    [HUD showInView:loadView1];
//}
//
//- (void)showToastWithMessage:(NSString *)message showTime:(float)time
//{
//    [CommentMethod showToastWithMessage:message showTime:time];
//}
//
//
//- (void)hideHud
//{
//    UIView *view1 = [self.view viewWithTag:98765];
//
//    if ([view1 viewWithTag:9902]) {
//        JGProgressHUD *HUD = [view1 viewWithTag:109];
//        [HUD dismissAnimated:YES];
//        [HUD removeFromSuperview];
//        HUD = nil;
//    }
//
//    if (view1) {
//        [view1 removeFromSuperview];
//        view1 = nil;
//    }
//
//    UIView *view2 = [self.view viewWithTag:987654];
//    if (view2) {
//        [view2 removeFromSuperview];
//        view2 = nil;
//    }
//}

@end
