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

#import <UIKit/UIKit.h>

typedef void(^KeyBoardWillShowBlock)(NSNotification *notification, CGFloat keyBoardHeight, CGFloat keyBoardTime);
typedef void(^KeyBoardWillDissmissBlock)(NSNotification *notification, CGFloat keyBoardTime);

@interface UIViewController (DismissKeyboard)

//键盘点击空白的地方，收起
-(void)setupForDismissKeyboard;

//键盘键盘的弹起和消失
- (void)addKeyBoardNotificationDoWillShow:(KeyBoardWillShowBlock)willShow  doDissmiss:(KeyBoardWillDissmissBlock)willDissmiss;

//移除键盘通知
- (void)removeKeyBoardNotification;



//私有
@property (nonatomic , copy) KeyBoardWillShowBlock willShowBlock;
@property (nonatomic , copy) KeyBoardWillDissmissBlock willDissmissBlock;


@end
