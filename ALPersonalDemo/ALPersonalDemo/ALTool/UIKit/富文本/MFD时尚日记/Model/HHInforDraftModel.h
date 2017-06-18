//
//  HHInforDraftModel.h
//  wwrj
//
//  Created by wwrj on 16/12/19.
//  Copyright © 2016年 wwrj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHImageStyle.h"
#import "RJTopicCategoryModel.h"
@interface HHInforDraftModel : NSObject
//@property (nonatomic, assign)int inforDraftId;
//@property (nonatomic, strong)NSString *jsonString;


@property (nonatomic, strong)NSString *ID;
@property (nonatomic, strong)HHImageStyle *coverImageStyle;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *specialTopicId;
@property (nonatomic, strong)NSString *specialTopicName;
@property (nonatomic, strong)NSAttributedString *attributeString;
@end
