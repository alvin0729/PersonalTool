//
//  UIView+Tracking.h
//  wwrj
//
//  Created by CC on 16/12/30.
//  Copyright © 2016年 wwrj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJClickCountLabel.h"

@interface UIView (Tracking)
@property (nonatomic, strong) RJClickCountLabel * numView;
@property (nonatomic,strong) NSString * trackingId;
//@property (nonatomic,strong) NSNumber * customerTreeId;
//@property (nonatomic, assign) BOOL isUseActionId;
- (void)showLabel;
- (void)removeLabel;
@end
