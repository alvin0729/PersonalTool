//
//  WWTagEditingView.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/1.
//  Copyright © 2017年 company. All rights reserved.
//

#import "WWTagEditingView.h"

#define kDisPathQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface WWTagEditingView() <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *btnTitleArray;

@end

@implementation WWTagEditingView

static CGFloat WWTagMinLength = 30;   //textfeild 最小保持宽度
static CGFloat WWDistanceLength = 8;
static CGFloat MWXTagCount = 3 ;

#pragma mark - 懒加载
-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array ];
    }
    return _btnArray;
}

-(NSMutableArray *)btnTitleArray{
    if (!_btnTitleArray) {
        _btnTitleArray = [NSMutableArray array];
    }
    return _btnTitleArray;
}

-(WWTagButtonTextField *)textField
{
    if (!_textField) {
        _textField = [[WWTagButtonTextField alloc] initWithFrame:[self updateTextFrame]];
        
        _textField.font = DDPingFangSCMediumFONT(12);
        _textField.textColor = [UIColor colorWithHexString:@"e5e5e5"];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.delegate = self;
        _textField.placeholder = @"请给故事贴上标签，按空格自动生成...";
        _textField.frame = CGRectMake(WWDistanceLength, WWDistanceLength, self.bounds.size.width-2*WWDistanceLength, 26); // 定制一个高度
        
        [_textField addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
        
        __weak typeof(self)WeakSelf = self;
        
        _textField.block = ^{
            if (![WeakSelf.textField hasText]) {
                UIButton*btn = WeakSelf.btnArray.lastObject;
                btn.state != UIControlStateSelected ?  [btn setSelected:YES]:[WeakSelf tagBtnClick:btn];
            }
        };
    }
    return _textField;
}

#pragma mark - 辅助
-(UIButton *)assBtn
{
    if (!_assBtn) {
        _assBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _assBtn.backgroundColor = [UIColor blueColor];
        _assBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_assBtn addTarget:self action:@selector(assBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _assBtn;
}


-(void)layoutSubviews
{
    [self addSubview:self.textField];
}


#pragma mark - 计算textField 位置
-(CGRect)updateTextFrame
{
    // x y 固定
    CGFloat height = 26;
    
    //计算宽高
    //取最后一个btn
    UIButton* btn = self.btnArray.lastObject;
    
    //无按钮 直接定位
    if (btn == nil) {
        return CGRectMake(WWDistanceLength, WWDistanceLength, self.bounds.size.width - 2 * WWDistanceLength, height);
    }
    
    // 占据的宽度   按钮宽度 ＋ x坐标偏移位置 ＋ 间距
    CGFloat widthPart = btn.frame.size.width + btn.frame.origin.x + WWDistanceLength;
    
    //x  view宽度 － 占据的宽度 > textfield 最小预留的宽度 ？   是否越界
    CGFloat x = self.bounds.size.width - widthPart > WWTagMinLength ? widthPart : WWDistanceLength;
    
    CGFloat y = self.bounds.size.width - widthPart > WWTagMinLength ? btn.frame.origin.y : btn.frame.origin.y + WWDistanceLength + btn.frame.size.height;
    
    CGFloat width = x == WWDistanceLength ? self.bounds.size.width - 2*WWDistanceLength : self.bounds.size.width - widthPart - WWDistanceLength;
    
    CGRect frame = CGRectMake(x,y , width, height);
    return frame;
}


#pragma mark - 添加btn
-(void)creatBtnWithTitle:(NSString*)btnTitle
{
    [self.btnTitleArray addObject:btnTitle];
    
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //去掉首尾空格
    //btnTitle = [btnTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([btnTitle isEqualToString:@""]||[btnTitle isKindOfClass:[NSNull class]]||btnTitle == nil) {
        NSLog(@"null");
        return;
    }
    if (btnTitle.length > 6) {
        NSLog(@"字符超过6个，请删除重新生成标签");
        return;
    }
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"bianji_delete"];
    attachment.bounds = CGRectMake(0, 0, 7, 7);
    NSAttributedString *attachmentStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *attrituteTitle = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" #%@ ",btnTitle]];
    [attrituteTitle insertAttributedString:attachmentStr atIndex:attrituteTitle.length];
    [attrituteTitle setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"fffa69"], NSFontAttributeName : DDPingFangSCMediumFONT(12)} range:NSMakeRange(0, attrituteTitle.length)];
    
    [btn setAttributedTitle:attrituteTitle forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
    //btn.titleEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    //btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    
    [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize sizeToFit = [attrituteTitle boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;

//    CGSize sizeToFit = [btnTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 26)
//                                              options:\
//                        NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                           attributes:@{NSFontAttributeName : DDPingFangSCMediumFONT(12)}
//                                              context:nil].size ;
    //提前在 上下左右 做好偏移
    
    btn.frame = CGRectMake(0, 0, sizeToFit.width+8 + 28, sizeToFit.height+4);
    
    //btn宽高
    if (btn.frame.size.width > self.frame.size.width - 2 * WWDistanceLength) {
        CGRect frame = btn.frame;
        frame.size.width = self.bounds.size.width - 2*WWDistanceLength;
        btn.frame = frame;
    }
    //判定
    UIButton*lastBtn = self.btnArray.lastObject;
    if (lastBtn == nil) {
        CGRect frame = btn.frame;
        frame.origin.x = WWDistanceLength;
        frame.origin.y = WWDistanceLength;
        btn.frame = frame;
    }else{
        CGFloat widthPart = lastBtn.frame.origin.x + lastBtn.frame.size.width + WWDistanceLength ;
        CGRect frame = btn.frame;
        frame.origin.x = self.bounds.size.width - widthPart > btn.frame.size.width ? widthPart : WWDistanceLength;
        frame.origin.y = self.bounds.size.width - widthPart > btn.frame.size.width ? lastBtn.frame.origin.y :lastBtn.frame.origin.y + lastBtn.frame.size.height + WWDistanceLength;
        btn.frame = frame;
        
    }
    
    //添加btn
    dispatch_async(kDisPathQueue, ^{
        NSMutableArray*titleAry = [NSMutableArray array ];
        for (int i = 0 ; i < self.btnArray.count; i++) {
            UIButton*btn = (UIButton*)self.btnArray[i];
            [titleAry addObject:btn.titleLabel.text];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![titleAry containsObject:btn.titleLabel.text]) {
                [self.btnArray addObject:btn];
                [self addSubview:btn];
                self.textField.frame = [self updateTextFrame];
            }else{
                NSLog(@"已经存在同名btn");
            }
        });
    });
    
    
    
    
}

#pragma mark - 点击按钮变动
-(void)tagBtnClick:(UIButton*)sender
{
    
    //点击 做判定是否select
    
    [sender removeFromSuperview];
    NSInteger index = [self.btnArray indexOfObject: sender];
    [self.btnArray removeObject:sender];
    [self.btnTitleArray removeObjectAtIndex:index];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self updateTagsFrame];
        self.textField.frame =  [self updateTextFrame];
        self.assBtn.frame = CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y+self.textField.frame.size.height, self.textField.frame.size.width, self.textField.frame.size.height);
    }];
    
}


//更新所有tagbtn的frame
-(void)updateTagsFrame
{
    UIButton *lastBtn = nil;
    for (int i = 0; i<self.btnArray.count; i++) {
        
        UIButton*btn = self.btnArray[i];
        CGRect frame = btn.frame;
        
        if (lastBtn == nil) {
            frame.origin.x = WWDistanceLength;
            frame.origin.y = WWDistanceLength;
        }else{
            CGFloat widthPart = lastBtn.frame.origin.x + lastBtn.frame.size.width + WWDistanceLength ;
            
            frame.origin.x = self.bounds.size.width - widthPart > btn.frame.size.width ? widthPart : WWDistanceLength;
            frame.origin.y = self.bounds.size.width - widthPart > btn.frame.size.width ? lastBtn.frame.origin.y :lastBtn.frame.origin.y + lastBtn.frame.size.height + WWDistanceLength;
        }
        
        btn.frame = frame;
        lastBtn = btn;
        
    }
}

//辅助按钮功能
-(void)assBtnClick
{
    [self textFieldShouldReturn:self.textField];
}



#pragma mark - textFeildDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.btnArray.count >= MWXTagCount) {
        return NO;
    }
    
    if ([textField.text isEqualToString:@" "]||[textField.text isKindOfClass:[NSNull class]]||textField.text == nil) {
        return NO;
    }
    
    [self creatBtnWithTitle:textField.text];
    self.textField.text = nil;
    [self.assBtn removeFromSuperview];
    return YES;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (self.btnArray.count >= MWXTagCount) {
        self.textField.text = nil;
        return NO;
    }
    
    if (string.length == 0) {
        return YES;
    }
    
    if ([self isChineseInput]==YES) {
        return YES;//中文的话交给textViewDidChange 计算
    }
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 6) {
        return NO;
    }
    if ([string isEqualToString:@" "] && range.location != 0 ) {
        if (self.btnTitleArray.count > 0) {
            for (NSString *title in self.btnTitleArray) {
                if ([title isEqualToString:string]) {
                    NSLog(@"==已经加入==");
                }else{
                    [self textFieldShouldReturn:self.textField];
                    return NO;
                }
            }
        } else{
            [self textFieldShouldReturn:self.textField];
            return NO;
        }
    }

    if ([string isEqualToString:@","]&&range.location != 0 ) {
        [self textFieldShouldReturn:self.textField];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;{
    if (self.btnArray.count > 0 || textField.text.length > 0) {
        self.textField.placeholder = @" ";
    }else{
        self.textField.placeholder = @"请给故事贴上标签，按空格自动生成...";
    }
}

#pragma mark - textFied tager
-(void)textFielddidChange:(UITextField*)sender
{
    
    
    if (self.btnArray.count > 0 || sender.text.length > 0) {
        self.textField.placeholder = @" ";
    }else{
        self.textField.placeholder = @"请给故事贴上标签，按空格自动生成...";
    }
    
    if ([self isChineseInput]==NO) {
        return;
    }
    else
    {
        if( [self isNotHighLightEdtingWithTextView:sender]==YES) {
            if (sender.text.length >=6)
            {//此时是非高亮状态
                NSString *subStr= [sender.text substringWithRange:NSMakeRange(0, 6)];
            }
        }
    }

    if (sender.text.length > 6) {
        sender.text = [sender.text substringToIndex:6];
    }
}

-(BOOL )isChineseInput
{
    
    NSString *primaryLanguage=  [[UIApplication sharedApplication]textInputMode].primaryLanguage ;
    // 键盘输入语言模式 英语为en-US 如果是中文为zh-Hans 表情 emoji
    //    NSLog(@"%@---%@-----%@",primaryLanguage,[UITextInputMode activeInputModes],primaryLanguage);
    return [primaryLanguage isEqualToString:@"zh-Hans"];
}

-(BOOL )isNotHighLightEdtingWithTextView:(UITextField *)textField
{
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分（就是在编辑蓝色的部分）
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if(selectedRange && position){
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        return NO;
    }
    else if (!position) {
        // 非高亮选择的字
        return YES;
    }
    else return NO;
    
}


@end
