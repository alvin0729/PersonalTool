//
//  HHLineStyleViewController.h
//  wwrj
//
//  Created by wwrj on 16/12/11.
//  Copyright © 2016年 wwrj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHImageStyle;
@protocol HHLineStyleViewControllerDelegate <NSObject>

- (void)yf_didSelectLineStyle:(HHImageStyle *)imageStyle;

@end
@interface HHLineStyleViewController : UIViewController

@property (nonatomic, weak) id<HHLineStyleViewControllerDelegate> delegate;
@end
