//
//  GVUserDefaults.h
//  GVUserDefaults
//
//  Created by Kevin Renskers on 18-12-12.
//  Copyright (c) 2012 Gangverk. All rights reserved.
//

// Removing it for debugging, starting with a clean slate every time
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];

#import <Foundation/Foundation.h>

@interface GVUserDefaults : NSObject

+ (instancetype)standardUserDefaults;

@end
