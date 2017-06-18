//
//  HHMenuPullButton.h
//  wwrj
//
//  Created by wwrj on 16/12/11.
//  Copyright © 2016年 wwrj. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HHMenuPullButton : UIButton
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)NSString *imageName;
- (void)selectedSpecialTopic:(NSString *)name;
- (void)selectedNone;
@end
