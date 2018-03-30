//
//  WWTagButtonTextField.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/1.
//  Copyright © 2017年 company. All rights reserved.
//

#import "WWTagButtonTextField.h"


@implementation WWTagButtonTextField

-(void)deleteBackward{
    
    if (self.block) {
        self.block();
    }
    [super deleteBackward];
}

@end
