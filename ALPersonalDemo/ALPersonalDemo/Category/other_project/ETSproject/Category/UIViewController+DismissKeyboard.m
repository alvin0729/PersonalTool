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

#import "UIViewController+DismissKeyboard.h"
#import <objc/runtime.h>

static void * KeyBoardWillShowBlockKey = (void *)@"KeyBoardWillShowBlockKey";
static void * KeyBoardWillDissmissBlockKey = (void *)@"KeyBoardWillDissmissBlockKey";

@implementation UIViewController (DismissKeyboard)

@dynamic willShowBlock;
@dynamic willDissmissBlock;
- (KeyBoardWillShowBlock)willShowBlock
{
    id object = objc_getAssociatedObject(self,KeyBoardWillShowBlockKey);
    return object;
}
- (void)setWillShowBlock:(KeyBoardWillShowBlock)willShowBlock
{
    objc_setAssociatedObject(self, KeyBoardWillShowBlockKey, willShowBlock, OBJC_ASSOCIATION_COPY);
}

- (KeyBoardWillDissmissBlock)willDissmissBlock
{
    id object = objc_getAssociatedObject(self,KeyBoardWillDissmissBlockKey);
    return object;
}
- (void)setWillDissmissBlock:(KeyBoardWillDissmissBlock)willDissmissBlock
{
    objc_setAssociatedObject(self, KeyBoardWillDissmissBlockKey, willDissmissBlock, OBJC_ASSOCIATION_COPY);
}

//键盘键盘的弹起和消失
- (void)addKeyBoardNotificationDoWillShow:(KeyBoardWillShowBlock)willShow  doDissmiss:(KeyBoardWillDissmissBlock)willDissmiss;
{
    self.willDissmissBlock = willDissmiss;
    self.willShowBlock  = willShow;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    //键盘高度
    float aHeight = keyboardSize.height;
    
    //时间
    float times = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    if (self.willShowBlock) {
        self.willShowBlock(notif, aHeight, times);
    }
}
- (void)keyboardWasHidden:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    float times = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (self.willDissmissBlock) {
        self.willDissmissBlock(notif, times);
    }
}


- (void)setupForDismissKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view endEditing:YES];
    }];
}

//移除键盘通知
- (void)removeKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}





@end
