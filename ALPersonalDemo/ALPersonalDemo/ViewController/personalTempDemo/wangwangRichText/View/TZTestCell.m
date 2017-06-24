//
//  TZTestCell.m
//  TZImagePickerController
//
//  Created by 谭真 on 16/1/3.
//  Copyright © 2016年 谭真. All rights reserved.
//

#import "TZTestCell.h"
#import "UIView+TZLayout.h"

@implementation TZModel
@end

static const CGFloat StripeWidth = 20.0f;

@interface TZTestCell()
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UILabel *afontTitleLabel;
@end

@implementation TZTestCell

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [self configUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [self configUI];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    self.afontTitleLabel.text = title;
}

-(void)setModel:(TZModel *)model{
    self.afontTitleLabel.text = model.fontKeyName;
}
-(void)configUI{
    [self.contentView addSubview:self.afontTitleLabel];
    [self.layer addSublayer:self.progressLayer];
    self.afontTitleLabel.center=self.center;
}

-(UILabel *)afontTitleLabel{
    if (!_afontTitleLabel) {
        _afontTitleLabel = [[UILabel alloc] init];
        //_afontTitleLabel.text = @"GIF";
        _afontTitleLabel.textColor = [UIColor whiteColor];
        _afontTitleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _afontTitleLabel.textAlignment = NSTextAlignmentCenter;
        _afontTitleLabel.font = [UIFont systemFontOfSize:10];
        _afontTitleLabel.frame = CGRectMake(self.tz_width - 25, self.tz_height - 14, self.bounds.size.width, 14);
    }
    return _afontTitleLabel;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor grayColor].CGColor;
        _progressLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 10, self.bounds.size.width, 10)].CGPath;
        _progressLayer.opacity = 0.5f;
        
        CABasicAnimation *flicker = [CABasicAnimation animationWithKeyPath:@"fillColor"];
        flicker.duration = 0.95;
        flicker.repeatCount = HUGE_VALF;
        flicker.removedOnCompletion = NO;
        flicker.autoreverses = YES;
        flicker.toValue = (id)[UIColor lightGrayColor].CGColor;
        flicker.fromValue = (id)[UIColor grayColor].CGColor;
        [_progressLayer addAnimation:flicker forKey:@"flicker"];
    }
    return _progressLayer;
}

- (void)setDownloadProgress:(double)downloadProgress {
    if (_downloadProgress != downloadProgress) {
        _downloadProgress = downloadProgress;
        CGRect frame = self.bounds;
        CGFloat width = frame.size.width;
        frame.origin.x = width * downloadProgress;
        frame.size.width =  width * (1.0f - downloadProgress);
        _progressLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 10, self.bounds.size.width, 10)].CGPath;
    }
    if (downloadProgress > 0.99999) {
        self.afontTitleLabel.backgroundColor = [UIColor cyanColor];
    }
}

//- (UIView *)snapshotView {
//    UIView *snapshotView = [[UIView alloc]init];
//    
//    UIView *cellSnapshotView = nil;
//    
//    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
//        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
//    } else {
//        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
//        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
//        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
//    }
//    
//    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
//    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
//    
//    [snapshotView addSubview:cellSnapshotView];
//    return snapshotView;
//}


@end
