//
//  WWCustomLimitDatePickerView.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/8/16.
//  Copyright © 2017年 company. All rights reserved.
//

#import "WWCustomLimitDatePickerView.h"


#define pickerMargin 10
#define pickerX pickerMargin
#define pickerW [UIScreen mainScreen].bounds.size.width - 2 * pickerMargin
#define pickerH [UIScreen mainScreen].bounds.size.height / 3.0
#define pickerY [UIScreen mainScreen].bounds.size.height - pickerH - pickerMargin * 2
#define kPickerItemHeight     40

//屏幕宽度
#define kPICKVIEW_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define kPICKVIEW_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
//字体大小
#define PickFont(font)  [UIFont systemFontOfSize:font]
//字体大小
#define PickFontColor(color)  [UIColor color]

#define kWWKeyWindow  [[[UIApplication sharedApplication] delegate] window]

@interface WWCustomLimitDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
/**
 * 数组装年份
 */
@property (nonatomic, strong) NSMutableArray *yearArray;
/**
 * 最小日期当月年剩下的月份
 */
@property (nonatomic, strong) NSMutableArray *minMonthRemainingArray;
/**
 * 最大日期当年已过去的月份
 */
@property (nonatomic, strong) NSMutableArray *maxMonthRemainingArray;
/**
 * 最小日期当月剩下的天数
 */
@property (nonatomic, strong) NSMutableArray *minDayRemainingArray;
/**
 * 最大日期当月过去的天数
 */
@property (nonatomic, strong) NSMutableArray *maxDayRemainingArray;

/**
 * 不是闰年 装一个月多少天
 */
@property (nonatomic, strong) NSArray *NotLeapYearArray;
/**
 * 闰年 装一个月多少天
 */
@property (nonatomic, strong) NSArray *leapYearArray;
@property (nonatomic, strong) NSDate *minimumDate;//最小时间
@property (nonatomic, strong) NSDate *maximumDate;//最大时间


/**  背景蒙版 **/
@property(nonatomic,strong)UIView * maskView;

/**  容器 **/
@property(nonatomic,strong)UIView * containerView;

@end

//弹框的高度
static CGFloat backViewH = 258;//大致是键盘的高度


@implementation WWCustomLimitDatePickerView
{
    UIPickerView *yearPicker;/**<年>*/
    UIPickerView *monthPicker;/**<月份>*/
    UIPickerView *dayPicker;/**<天>*/
    NSInteger minYear;
    NSInteger minMonth;
    NSInteger minDay;
    NSInteger maxYear;
    NSInteger maxMonth;
    NSInteger maxDay;
}


+ (instancetype)initCustomLimitDatePicker{
    return  [[self alloc]init];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    
    if ([super initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)]) {
        [self initMaskView];
        [self initTopView];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initContainerView];
        [self configAppearance];
        [self setViews];
    }
    return self;
}

//外观
-(void)configAppearance{
    
    //创建贝塞尔曲线
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, pickerW, pickerH) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
    
    //创建layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置layer大小
    maskLayer.frame = CGRectMake(0, 0, pickerW, pickerH);
    //设置layer路径
    maskLayer.path = maskPath.CGPath;
    //设置需要切圆角的layer
    self.containerView.layer.mask = maskLayer;
}

- (void)initTopView{
    
    CGFloat toolBarW=self.bounds.size.width;
    CGFloat toolBarH=self.bounds.size.height / 5.0;
    
    CGFloat btnW=50.0;
    
    self.topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, toolBarW, toolBarH)];
    self.topView.backgroundColor=[UIColor whiteColor];
    UIButton *cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 0, btnW, toolBarH)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"#bfbfbf"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton=[[UIButton alloc] initWithFrame:CGRectMake(pickerW-btnW-10, 0, btnW, toolBarH)];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:cancelButton];
    [self.topView addSubview:confirmButton];
    [self addSubview:self.topView];
}
- (void)initMaskView{
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kPICKVIEW_SCREEN_WIDTH, kPICKVIEW_SCREEN_HEIGHT)];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.maskView.userInteractionEnabled = YES;
    [ self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithAnimation)]];
}

-(void)cancelButtonClick{
    [self hiddenWithAnimation];
}
-(void)confirmButtonClick{
    [self hiddenWithAnimation];
    [self sureAction];
}

- (void)initContainerView{
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
    self.containerView.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    
    //非闰年
    self.NotLeapYearArray = @[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    //闰年
    self.leapYearArray = @[@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    
    //获得最小的年月日,最大的年月日
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    minYear = [[dateFormatter stringFromDate:_minimumDate] integerValue];
    maxYear = [[dateFormatter stringFromDate:_maximumDate] integerValue];
    [dateFormatter setDateFormat:@"MM"];
    minMonth = [[dateFormatter stringFromDate:_minimumDate] integerValue];
    maxMonth = [[dateFormatter stringFromDate:_maximumDate] integerValue];
    [dateFormatter setDateFormat:@"dd"];
    minDay = [[dateFormatter stringFromDate:_minimumDate] integerValue];
    maxDay = [[dateFormatter stringFromDate:_maximumDate] integerValue];
    
    
    for (NSInteger yearNum = minYear; yearNum <= maxYear; yearNum ++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%ld",(long)yearNum]];//年份
    }
    
    //最小年份剩下的月份数
    for (NSInteger monthNum = minMonth; monthNum <= 12 ; monthNum ++) {
        [self.minMonthRemainingArray addObject:[NSString stringWithFormat:@"%ld",(long)monthNum]];
    }
    //最大年份已过去的月份数
    for (NSInteger monthNum = 1; monthNum <= maxMonth; monthNum++) {
        [self.maxMonthRemainingArray addObject:[NSString stringWithFormat:@"%ld",(long)monthNum]];
    }
    //最小日期剩下的天数
    NSInteger lastDay = [self LeapYearCompare:minYear withMonth:minMonth];
    for (NSInteger dayNum = minDay; dayNum <= lastDay; dayNum ++) {
        [self.minDayRemainingArray addObject:[NSString stringWithFormat:@"%ld",(long)dayNum]];
    }
    //最大日期过去的天数
    for (NSInteger dayNum = 1; dayNum <= maxDay; dayNum ++) {
        [self.maxDayRemainingArray addObject:[NSString stringWithFormat:@"%ld",(long)dayNum]];
    }
    
}

- (void)setViews{
    
    CGFloat margin = 20.0f;
    CGFloat leftMargin = (kPICKVIEW_SCREEN_WIDTH - (70+60+60+20*2))/2.0;
    //年
    //时间选择器
    yearPicker = [[UIPickerView alloc]init];
    yearPicker.frame = CGRectMake(leftMargin, self.topView.bounds.size.height, 70, pickerH - self.topView.bounds.size.height);
    yearPicker.delegate = self;
    yearPicker.dataSource = self;
    //月
    monthPicker = [[UIPickerView alloc]init];
    monthPicker.frame = CGRectMake(CGRectGetMaxX(yearPicker.frame)+margin,self.topView.bounds.size.height, 60, pickerH - self.topView.bounds.size.height);
    monthPicker.delegate = self;
    yearPicker.dataSource = self;
    //日
    dayPicker = [[UIPickerView alloc]init];
    dayPicker.frame = CGRectMake(CGRectGetMaxX(monthPicker.frame)+margin, self.topView.bounds.size.height, 60, pickerH - self.topView.bounds.size.height);
    dayPicker.delegate = self;
    dayPicker.dataSource = self;
}

#pragma mark - pickerView的delegate方法

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == yearPicker) {
        [monthPicker reloadAllComponents];
        [dayPicker reloadAllComponents];
        
    }else if (pickerView == monthPicker){
        [dayPicker reloadAllComponents];
    }else{
        
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == yearPicker) {
        return self.yearArray.count;
    }else if (pickerView == monthPicker){
        return [self MonthInSelectYear];
    }else{
        return [self daysInSelectMonth];
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return kPickerItemHeight;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 64;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *rowLabel = [[UILabel alloc]init];
    rowLabel.textAlignment = NSTextAlignmentCenter;
    rowLabel.backgroundColor = [UIColor whiteColor];
    rowLabel.frame = CGRectMake(0, 0, pickerView.bounds.size.width,self.frame.size.width);
    rowLabel.textAlignment = NSTextAlignmentCenter;
    rowLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    rowLabel.textColor = [UIColor orangeColor];
    
    [pickerView.subviews[1] setHidden:YES];
    [pickerView.subviews[2] setHidden:YES];
    [pickerView.subviews[1] setBackgroundColor:[UIColor redColor]];
    [pickerView.subviews[2] setBackgroundColor:[UIColor greenColor]];
    [rowLabel sizeToFit];
    
    if (pickerView == yearPicker) {
        rowLabel.text =  [NSString stringWithFormat:@"%@年",self.yearArray[row]];
        return rowLabel;
    }else if(pickerView == monthPicker){
        NSInteger yearRow = [yearPicker selectedRowInComponent:0] % self.yearArray.count;
        if ([self.yearArray[yearRow] integerValue] == minYear) {
            NSInteger selectrow = row > _minMonthRemainingArray.count - 1 ?_minMonthRemainingArray.count -1 :row;
            rowLabel.text = [NSString stringWithFormat:@"%ld月",(long)[self.minMonthRemainingArray[selectrow] integerValue]];
        }else if ([self.yearArray[yearRow] integerValue] == maxYear){
            NSInteger selectrow = row > _maxMonthRemainingArray.count - 1 ?_maxMonthRemainingArray.count -1:row;
            rowLabel.text = [NSString stringWithFormat:@"%ld月",(long)[self.maxMonthRemainingArray[selectrow] integerValue]];
        }else{
            rowLabel.text = [NSString stringWithFormat:@"%ld月",row % 12 + 1];
        }
        return rowLabel;
    }else{
        NSInteger yearRow = [yearPicker selectedRowInComponent:0] % self.yearArray.count;
        NSInteger monthRow = [monthPicker selectedRowInComponent:0] % 12;
        
        if ([self.yearArray[yearRow] integerValue] == minYear) {
            if ([self.minMonthRemainingArray[monthRow] integerValue] == minMonth) {
                NSInteger selectrow = row > _minDayRemainingArray.count - 1 ?_minDayRemainingArray.count -1 :row;
                rowLabel.text = [NSString stringWithFormat:@"%ld日",(long)[self.minDayRemainingArray[selectrow] integerValue] ];
            }else{
                NSInteger monthRemainingDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:[self.minMonthRemainingArray[monthRow] integerValue]];
                
                rowLabel.text = [NSString stringWithFormat:@"%ld日", row % monthRemainingDays + 1];
            }
        }else if([self.yearArray[yearRow] integerValue] == minYear){
            if ([self.maxMonthRemainingArray[monthRow] integerValue] == maxMonth) {
                NSInteger selectrow = row > _maxDayRemainingArray.count - 1 ?_maxDayRemainingArray.count -1 :row;
                rowLabel.text = [NSString stringWithFormat:@"%ld日",(long)[self.maxDayRemainingArray[selectrow] integerValue] ];
            }else{
                NSInteger monthRemainingDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:[self.maxMonthRemainingArray[monthRow] integerValue]];
                
                rowLabel.text = [NSString stringWithFormat:@"%ld日", row % monthRemainingDays + 1];
            }
        }else{
            NSInteger monthDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:(monthRow + 1)];
            rowLabel.text = [NSString stringWithFormat:@"%ld日", row % monthDays + 1];
        }
        
        return rowLabel;
    }
}
- (void)cancelAction{
    [yearPicker selectRow:0 inComponent:0 animated:YES];
    [monthPicker selectRow:0 inComponent:0 animated:YES];
    [dayPicker selectRow:0 inComponent:0 animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(cancelDatePicker)]) {
        [self.delegate cancelDatePicker];
    }
}

-(void)sureAction{
    
    NSString *yearStr = @"";
    NSString *monthStr = @"";
    NSString *dayStr = @"";
    NSInteger yearRow = [yearPicker selectedRowInComponent:0];
    NSInteger monthRow = [monthPicker selectedRowInComponent:0];
    NSInteger dayRow = [dayPicker selectedRowInComponent:0];
    yearStr = self.yearArray[yearRow];
    NSInteger monthDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:(monthRow + 1)];
    if ([self.yearArray[yearRow] integerValue] == minYear) {
        monthStr = self.minMonthRemainingArray[monthRow];
        if ([self.minMonthRemainingArray[monthRow] integerValue] == minMonth) {
            dayStr = self.minDayRemainingArray[dayRow];
        }else{
            NSInteger monthRemainingDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:[self.minMonthRemainingArray[monthRow] integerValue]];
            dayStr = [NSString stringWithFormat:@"%ld",dayRow % monthRemainingDays + 1];
        }
    }else if([self.yearArray[yearRow] integerValue] == minYear){
        monthStr = self.maxMonthRemainingArray[monthRow];
        if ([self.maxMonthRemainingArray[monthRow] integerValue] == maxMonth) {
            dayStr = self.maxDayRemainingArray[dayRow];
        }else{
            NSInteger monthRemainingDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:[self.maxMonthRemainingArray[monthRow] integerValue]];
            dayStr = [NSString stringWithFormat:@"%ld",dayRow % monthRemainingDays + 1];
        }
    }else{
        monthStr = [NSString stringWithFormat:@"%ld",monthRow%12 + 1];
        dayStr = [NSString stringWithFormat:@"%ld", dayRow % monthDays + 1];
    }
    
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%02ld-%02ld",yearStr,[monthStr integerValue],[dayStr integerValue]];
    
    if ([self.delegate respondsToSelector:@selector(didSelectedDateString:)]) {
        [self.delegate didSelectedDateString:dateStr];
    }
    
    
    if (self.LimitDatePickerDidSelectedDateString) {
        self.LimitDatePickerDidSelectedDateString(dateStr);
    }
    
}

#pragma mark - 判断是否是闰年(返回的的值,天数)
- (NSInteger)LeapYearCompare:(NSInteger)year withMonth:(NSInteger)month{
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return [self.leapYearArray[month - 1] integerValue];
    }else{
        return [self.NotLeapYearArray[month - 1] integerValue];
    }
}

/**
 * 返回有多少个月
 */
- (NSInteger)MonthInSelectYear{
    NSInteger yearRow = [yearPicker selectedRowInComponent:0];
    if ([self.yearArray[yearRow] integerValue] == minYear) {
        return _minMonthRemainingArray.count;
    }else if ([self.yearArray[yearRow] integerValue] == maxYear){
        return _maxMonthRemainingArray.count;
    }else {
        return 12;
    }
}

/**
 * 返回有多少天
 */
- (NSInteger)daysInSelectMonth{
    
    NSInteger yearRow = [yearPicker selectedRowInComponent:0] % self.yearArray.count;
    NSInteger monthRow = [monthPicker selectedRowInComponent:0] % 12;
    if ([self.yearArray[yearRow] integerValue] == minYear) {
        if ([self.minMonthRemainingArray[monthRow] integerValue] == minMonth) {
            return _minDayRemainingArray.count;
        }else{
            NSInteger monthRemainingDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:[self.minMonthRemainingArray[monthRow] integerValue]];
            return monthRemainingDays;
        }
    }else if ([self.yearArray[yearRow] integerValue] == maxYear){
        if ([self.maxMonthRemainingArray[monthRow]  integerValue]  == maxMonth){
            return _maxDayRemainingArray.count;
        }else{
            NSInteger monthRemainingDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:[self.maxMonthRemainingArray[monthRow] integerValue]];
            return monthRemainingDays;
        }
    }else{
        NSInteger monthDays = [self LeapYearCompare:[self.yearArray[yearRow] integerValue] withMonth:monthRow + 1];
        return monthDays;
    }
}


- (void)showWithMaxDateString:(NSString *)maxString withMinDateString:(NSString *)minString didSeletedDateStringBlock:(void (^)(NSString *dateString))dateStringBlock{
    
    self.LimitDatePickerDidSelectedDateString = dateStringBlock;
    [self removeFromSuperview];
    
    self.yearArray = [NSMutableArray array];
    self.minMonthRemainingArray = [NSMutableArray array];
    self.maxMonthRemainingArray = [NSMutableArray array];
    self.minDayRemainingArray = [NSMutableArray array];
    self.maxDayRemainingArray = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *maxDate = [dateFormatter dateFromString:([maxString isEqualToString:@""]||[maxString isEqual:[NSNull null]]||maxString==nil)?@"2010-12-31":maxString];
    NSDate *minDate = [dateFormatter dateFromString:([minString isEqualToString:@""]||[minString isEqual:[NSNull null]]||minString==nil)?@"1960-01-01":minString];
    NSDate *tenYearsbefore = minDate;
    NSDate *tenYearsLater = maxDate;
    self.minimumDate = tenYearsbefore;
    self.maximumDate = tenYearsLater;
    [self initData];
    
    [yearPicker reloadAllComponents];
    [monthPicker reloadAllComponents];
    [dayPicker reloadAllComponents];
    
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSLog(@"currentDate %@ birthDay %@",currentDateStr,self.minimumDate);
    NSTimeInterval time = [currentDate timeIntervalSinceDate:self.minimumDate];
    int age = ((int)time)/(3600*24*365);
    NSLog(@"year %d",age);
    
    //获取当前时间
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear  | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSDateComponents *dateComponentTwo = [calendar components:unitFlags fromDate:self.minimumDate];
    
    NSDateComponents *maxdateComponent= [calendar components:unitFlags fromDate:self.maximumDate];
    
    //同时为空
    if ([self haveNull:maxString]  && [self haveNull:minString]) {
        //默认选中某个row
        [yearPicker selectRow:[dateComponent year]-[dateComponentTwo year] inComponent:0 animated:NO];
        [monthPicker selectRow:([dateComponent month]-[dateComponentTwo month]==0?0:[dateComponent month]-1) inComponent:0 animated:NO];
        [dayPicker selectRow: ([dateComponent day]-[dateComponentTwo day]==0?0:[dateComponent day]-1)   inComponent:0 animated:NO];
        
    }else if (![self haveNull:maxString] && ![self haveNull:minString])
    {
        //maxstring minstring 均存在值
        //默认选中某个row
//        [yearPicker selectRow:[dateComponent year]-[dateComponentTwo year] inComponent:0 animated:NO];
//        [monthPicker selectRow:([dateComponent month]-[dateComponentTwo month]==0?0:[dateComponent month]-1) inComponent:0 animated:NO];
//        [dayPicker selectRow: ([dateComponent day]-[dateComponentTwo day]==0?0:[dateComponent day]-1)   inComponent:0 animated:NO];
        [yearPicker selectRow:(int)self.yearArray.count / 2.0 inComponent:0 animated:NO];
        [monthPicker selectRow:6 inComponent:0 animated:NO];
        [dayPicker selectRow:15   inComponent:0 animated:NO];
        
    }else if (![self haveNull:maxString] )
    {
        if ([maxdateComponent year]-[dateComponent year]<=0) {
            //最大时间==当前时间 设置滚动到当前时间
            if ([maxdateComponent year]-[dateComponent year]==0) {
                //默认选中某个row
                [yearPicker selectRow:self.yearArray.count-1 inComponent:0 animated:NO];
                [monthPicker selectRow:[dateComponent month]-1 inComponent:0 animated:NO];
                [dayPicker selectRow: [dateComponent day]-1   inComponent:0 animated:NO];
            }else{
                //最大时间 <当前时间
                [yearPicker selectRow:self.yearArray.count-1 inComponent:0 animated:NO];
                [monthPicker selectRow:[maxdateComponent month]-1 inComponent:0 animated:NO];
                [dayPicker selectRow: [maxdateComponent day]-1   inComponent:0 animated:NO];
            }
            
        }else{
            //最大时间>当前时间 设置滚动到当前时间
            [yearPicker selectRow:self.yearArray.count-([maxdateComponent year]-[dateComponent year]+1) inComponent:0 animated:NO];
            [monthPicker selectRow:([dateComponent month]-1) inComponent:0 animated:NO];
            [dayPicker selectRow:([dateComponent day]-1) inComponent:0 animated:NO];
        }
        //maxstring  存在值 minstring为空
        NSLog(@"maxstring  存在值 minstring为空");
    }else if (![self haveNull:minString])
    {
        if ([dateComponent year]-[dateComponentTwo year]<=0) {
            //最小时间==当前时间 设置滚动到最小时间
            if ([dateComponent year]-[dateComponentTwo year]==0) {
                //默认选中某个row
                [yearPicker selectRow:0 inComponent:0 animated:NO];
                [monthPicker selectRow:0 inComponent:0 animated:NO];
                [dayPicker selectRow: 0   inComponent:0 animated:NO];
            }else{
                //最小时间 >当前时间 设置滚动到当前时间
                [yearPicker selectRow:0 inComponent:0 animated:NO];
                [monthPicker selectRow:0 inComponent:0 animated:NO];
                [dayPicker selectRow: 0   inComponent:0 animated:NO];
            }
        }else{
            //最小时间<当前时间 设置滚动到当前时间
            [yearPicker selectRow:[dateComponent year]-[dateComponentTwo year] inComponent:0 animated:NO];
            [monthPicker selectRow:([dateComponent month]-1) inComponent:0 animated:NO];
            [dayPicker selectRow:([dateComponent day]-1) inComponent:0 animated:NO];
            
        }
        //maxstring  为空 minstring存在值
        NSLog(@"maxstring  为空 minstring存在值");
    }else{
        NSLog(@"else ==%@ %@ ",maxString,minString);
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    
    [window addSubview:self.containerView];
    [self.containerView addSubview:self];
    [self.containerView addSubview:self.topView];
    [self.containerView addSubview:yearPicker];
    [self.containerView addSubview:monthPicker];
    [self.containerView addSubview:dayPicker];
    
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [self.containerView setFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
    
    CGFloat height = self.containerView.frame.size.height;
    
    self.containerView.center = CGPointMake(kPICKVIEW_SCREEN_WIDTH / 2, kPICKVIEW_SCREEN_HEIGHT + height / 2 - 10);
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kPICKVIEW_SCREEN_WIDTH / 2, kPICKVIEW_SCREEN_HEIGHT - height / 2 - 10);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
    
    for (int i = 0 ; i <2; i++) {
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, (self.containerView.bounds.size.height-self.topView.bounds.size.height-kPickerItemHeight)/2.0+self.topView.bounds.size.height+i*kPickerItemHeight, pickerW, 1)];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.containerView addSubview:lineView];
    }
}

- (BOOL)haveNull:(NSString *)string{
    if ([string isEqualToString:@""]||[string isEqual:[NSNull null]]||string==nil) {
        return YES;
    }else{
        return NO;
    }
}

- (void)hiddenWithAnimation
{
    CGFloat height = self.containerView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kPICKVIEW_SCREEN_WIDTH / 2, kPICKVIEW_SCREEN_HEIGHT + height / 2);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self hiddenViews];
    }];
    
}
- (void)hiddenViews {
    [self removeFromSuperview];
    [self.topView removeFromSuperview];
    [self.maskView removeFromSuperview];
    [self.containerView removeFromSuperview];
}

- (void)clearSpearatorLine:(UIView *)subView
{
    for (UIView * subView1  in subView.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView * subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    subView2.hidden = YES;//隐藏分割线
                }
            }
        }
    }
}

- (void)compareYear{
    //计算年龄
    NSString *birth = @"1993-10-30";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    NSLog(@"year %d",age);
}

@end
