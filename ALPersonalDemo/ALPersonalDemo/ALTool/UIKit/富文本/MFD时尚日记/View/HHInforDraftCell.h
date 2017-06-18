//
//  HHInforDraftCell.h
//  wwrj
//
//  Created by wwrj on 16/12/19.
//  Copyright © 2016年 wwrj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHInforDraftModel.h"
@interface HHInforDraftCell : UITableViewCell
@property (nonatomic, strong)HHInforDraftModel *model;
@property (nonatomic, assign)BOOL isShowDeleteBtn;
@property (nonatomic,copy) void (^deleteBlock)();
@end
