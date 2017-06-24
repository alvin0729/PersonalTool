//
//  TZTestCell.h
//  TZImagePickerController
//
//  Created by 谭真 on 16/1/3.
//  Copyright © 2016年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHHorizontalLineViewCell.h"

@interface TZModel : NSObject

@property (nonatomic, copy) NSString *fontKeyName;
@property (nonatomic, copy) NSString *fontValueName;

@end

@interface TZTestCell : UICollectionViewCell

@property (nonatomic, strong) TZModel *model;
@property (nonatomic, assign) double downloadProgress;

@property (nonatomic, copy) NSString *title;

//- (UIView *)snapshotView;

@end

