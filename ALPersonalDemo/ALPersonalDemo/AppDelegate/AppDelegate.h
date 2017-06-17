//
//  AppDelegate.h
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MHAccount.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

/**
 *  用户数据 只读
 */
@property (nonatomic , strong ,readonly) MHAccount *account;
/**
 *  获取delegate
 *
 */
+ (AppDelegate *)sharedDelegate;


@end

