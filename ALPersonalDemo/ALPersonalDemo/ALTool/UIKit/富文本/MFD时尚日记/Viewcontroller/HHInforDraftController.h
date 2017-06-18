//
//  HHInforDraftController.h
//  wwrj
//
//  Created by wwrj on 16/12/14.
//  Copyright © 2016年 wwrj. All rights reserved.
//

#import "RJBasicViewController.h"
#import "HHInforDraftModel.h"
@protocol HHInforDraftControllerDelegate <NSObject>

- (void)didSelectDraftWithModel:(HHInforDraftModel *)model;

@end

@interface HHInforDraftController : RJBasicViewController
@property (nonatomic,strong)NSString *htmlString;
@property (nonatomic,assign)id<HHInforDraftControllerDelegate> delegate;
@end
