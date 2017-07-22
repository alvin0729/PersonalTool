//
//  WWDropDownMenu.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/7/20.
//  Copyright © 2017年 company. All rights reserved.
//

#import "WWDropDownMenu.h"


#define VIEW_CENTER(aView)       ((aView).center)
#define VIEW_CENTER_X(aView)     ((aView).center.x)
#define VIEW_CENTER_Y(aView)     ((aView).center.y)

#define FRAME_ORIGIN(aFrame)     ((aFrame).origin)
#define FRAME_X(aFrame)          ((aFrame).origin.x)
#define FRAME_Y(aFrame)          ((aFrame).origin.y)

#define FRAME_SIZE(aFrame)       ((aFrame).size)
#define FRAME_HEIGHT(aFrame)     ((aFrame).size.height)
#define FRAME_WIDTH(aFrame)      ((aFrame).size.width)



#define VIEW_BOUNDS(aView)       ((aView).bounds)

#define VIEW_FRAME(aView)        ((aView).frame)

#define VIEW_ORIGIN(aView)       ((aView).frame.origin)
#define VIEW_X(aView)            ((aView).frame.origin.x)
#define VIEW_Y(aView)            ((aView).frame.origin.y)

#define VIEW_SIZE(aView)         ((aView).frame.size)
#define VIEW_HEIGHT(aView)       ((aView).frame.size.height)
#define VIEW_WIDTH(aView)        ((aView).frame.size.width)


#define VIEW_X_Right(aView)      ((aView).frame.origin.x + (aView).frame.size.width)
#define VIEW_Y_Bottom(aView)     ((aView).frame.origin.y + (aView).frame.size.height)

#define AnimateTime 0.25f   // 下拉动画时间

@interface WWDropDownMenu (){
    UIImageView * _arrowMark;   // 尖头图标
    UIView      * _listView;    // 下拉列表背景View
    UIButton    * _listButton;  // 单选按钮
    
    NSMutableArray     * _titleArr;    // 选项数组
    CGFloat       _rowHeight;          // 下拉列表行高
    BOOL          _isNotFirst;
}

@end

@implementation WWDropDownMenu

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMainBtnWithFrame:frame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self createMainBtnWithFrame:frame];
}


- (void)createMainBtnWithFrame:(CGRect)frame{
    
    [_mainBtn removeFromSuperview];
    _mainBtn = nil;
    
    _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mainBtn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [_mainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_mainBtn setTitle:@"往往" forState:UIControlStateNormal];
    [_mainBtn addTarget:self action:@selector(clickMainBtn:) forControlEvents:UIControlEventTouchUpInside];
    _mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _mainBtn.titleLabel.font    = [UIFont systemFontOfSize:14.f];
    _mainBtn.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);
    _mainBtn.selected           = NO;
    _mainBtn.backgroundColor    = [UIColor whiteColor];
    _mainBtn.layer.borderColor  = [UIColor blackColor].CGColor;
    _mainBtn.layer.borderWidth  = 1;
    
    [self addSubview:_mainBtn];
    
    
    // 旋转尖头
    _arrowMark = [[UIImageView alloc] initWithFrame:CGRectMake(_mainBtn.frame.size.width - 15, 0, 9, 9)];
    _arrowMark.center = CGPointMake(VIEW_CENTER_X(_arrowMark), VIEW_HEIGHT(_mainBtn)/2);
    _arrowMark.image  = [UIImage imageNamed:@"dropdownMenu_cornerIcon.png"];
    [_mainBtn addSubview:_arrowMark];
    
}

- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight{
    
    if (self == nil) {
        return;
    }
    
    _titleArr  = [NSMutableArray arrayWithArray:titlesArr];
    _rowHeight = rowHeight;
    
    
    // 下拉列表背景View
    _listView = [[UIView alloc] init];
    _listView.frame = CGRectMake(VIEW_X(self) , VIEW_Y_Bottom(self), VIEW_WIDTH(self),  0);
    _listView.clipsToBounds       = YES;
    _listView.layer.masksToBounds = NO;
    _listView.layer.borderColor   = [UIColor redColor].CGColor;
    _listView.layer.borderWidth   = 0.5f;
    
    
    // 下拉列表UIButton
    _listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_listButton setFrame:CGRectMake(0, 0,VIEW_WIDTH(_listView), VIEW_HEIGHT(_listView))];
    [_listButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_listButton addTarget:self action:@selector(clickListBtn:) forControlEvents:UIControlEventTouchUpInside];
    _listButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _listButton.titleLabel.font    = [UIFont systemFontOfSize:14.f];
    _listButton.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);
    _listButton.selected           = NO;
    _listButton.backgroundColor    = [UIColor orangeColor];
    _listButton.layer.borderColor  = [UIColor blackColor].CGColor;
    _listButton.layer.borderWidth  = 1;
    [_listView addSubview:_listButton];
}

- (void)clickMainBtn:(UIButton *)button{
    
    [self.superview addSubview:_listView];
    
    if(button.selected == NO) {
        [self showDropDown];
    }
    else {
        [self hideDropDown];
    }
}

- (void)clickListBtn:(UIButton *)button{
    
    [_listButton setTitle:_titleArr.lastObject forState:UIControlStateNormal];
    [_titleArr exchangeObjectAtIndex:0 withObjectAtIndex:1];
    [self hideDropDown];
}

- (void)showDropDown{   // 显示下拉列表
    // 将下拉列表置于最上层
    [_listView.superview bringSubviewToFront:_listView];
    _listButton.hidden = NO;
    [UIView animateWithDuration:AnimateTime animations:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!_isNotFirst) {
                _isNotFirst = YES;
                [_listButton setTitle:_titleArr.lastObject forState:UIControlStateNormal];
            }else{
                [_listButton setTitle:_titleArr.firstObject forState:UIControlStateNormal];
            }
            _arrowMark.transform = CGAffineTransformMakeRotation(M_PI);
            _listView.frame  = CGRectMake(VIEW_X(_listView), VIEW_Y(_listView), VIEW_WIDTH(_listView), _rowHeight * (_titleArr.count-1));
            _listButton.frame = CGRectMake(0, 0, VIEW_WIDTH(_listView), VIEW_HEIGHT(_listView));
        }); 
    }completion:^(BOOL finished) {
        
    }];
    _mainBtn.selected = YES;
}
- (void)hideDropDown{
    [UIView animateWithDuration:AnimateTime animations:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            _arrowMark.transform = CGAffineTransformIdentity;
            _listView.frame  = CGRectMake(VIEW_X(_listView), VIEW_Y(_listView), VIEW_WIDTH(_listView), 0);
            _listButton.frame = CGRectMake(0, 0, VIEW_WIDTH(_listView), VIEW_HEIGHT(_listView));
            _listButton.hidden = YES;
        });
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidHidden:mainBtnTitle:)]) {
            [self.delegate dropdownMenuDidHidden:self mainBtnTitle:_mainBtn.titleLabel.text]; // 已经隐藏回调代理
        }
    }];
    _mainBtn.selected = NO;
    [_mainBtn setTitle:_titleArr.lastObject forState:UIControlStateNormal];
    
}



@end







