//
//  WWCalourseView.h
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/8/22.
//  Copyright © 2017年 company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWCalourseCell.h"

@protocol WWCalourseViewDataSource <NSObject>

@required
-(void)WWCalourseViewWith:(WWCalourseCell*)Cell andIndex:(NSInteger)index;
-(NSInteger)WWCalourseNumber;
@end

@interface WWCalourseView : UIView

@property(nonatomic,assign) CGFloat scaleFloat;
@property(nonatomic,assign) CGFloat margin;
@property(nonatomic,weak) id<WWCalourseViewDataSource> DataSource;

-(void)animationChange;

@end
