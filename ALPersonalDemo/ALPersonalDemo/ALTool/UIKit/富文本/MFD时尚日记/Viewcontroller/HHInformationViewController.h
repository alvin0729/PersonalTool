//
//  HHInformationViewController.h
//  wwrj
//
//  Created by wwrj on 16/12/9.
//  Copyright © 2016年 wwrj. All rights reserved.
//

#import "RJBasicViewController.h"
#import "HHImageStyle.h"
#import "HHInforDraftModel.h"
@interface HHInformationViewController : RJBasicViewController
- (void)insertImageWithImageStyle:(HHImageStyle *)imageStyle;
/** 新建资讯，删除资讯内容 */
- (void)deleteInformation;
@end
