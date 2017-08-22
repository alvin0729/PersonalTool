//
//  ALDemo1ViewController.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/1.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALDemo1ViewController.h"
#import "WWTagEditingView.h"
#import "BBAlertView.h"
#import "MHYouKuTopicController.h"
#import "HHInformationViewController.h"
#import "ALRichTextDemoViewController.h"
#import "ALRIchTextDemoViewControllernone.h"
#import "WWDropDownMenu.h"
#import "MHTopicOneController.h"
#import "MHTopicTwoController.h"
#import "WWCustomLimitDatePickerView.h"
#import "WWCalourseView.h"


@interface ALDemo1ViewController ()<WWDropdownMenuDelegate,WWCalourseViewDataSource>

@property(nonatomic,strong)WWTagEditingView *edtingView;
@property(nonatomic,strong)WWCalourseView* calourse;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation ALDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:@"2020-08-06" withMinDateString:@"1993-01-01" didSeletedDateStringBlock:^(NSString *dateString) {
//        
//        NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
//        AlertShow(showString)
//        
//    }];
    
//    WWCustomLimitDatePickerView *limitDatePicker = [WWCustomLimitDatePickerView initCustomLimitDatePicker];
//    [limitDatePicker showWithMaxDateString:@"2010-12-31" withMinDateString:@"1960-01-01" didSeletedDateStringBlock:^(NSString *dateString) {
//        NSLog(@"🤗🤗🤗🤗🤗%@🤗🤗🤗🤗",dateString);
//    }];
    
    //MHYouKuTopicController *vc = [MHYouKuTopicController new];
    //[self.navigationController pushViewController:vc animated:NO];

    
//    MHTopicOneController *vc = [MHTopicOneController new];
//    [self.navigationController pushViewController:vc animated:NO];
    
    
//    MHTopicTwoController *vc = [MHTopicTwoController new];
//    [self.navigationController pushViewController:vc animated:NO];
    
    //HHInformationViewController *vc = [HHInformationViewController new];
    //[self.navigationController pushViewController:vc animated:NO];
    
    
//    ALRichTextDemoViewController *vc = [ALRichTextDemoViewController new];
//    [self.navigationController pushViewController:vc animated:NO];
    
//    ALRIchTextDemoViewControllernone *vc = [ALRIchTextDemoViewControllernone new];
//    [self.navigationController pushViewController:vc animated:NO];
    
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
//    WWDropDownMenu * dropdownMenu = [[WWDropDownMenu alloc] init];
//    [dropdownMenu setFrame:CGRectMake(20, 80, 100, 40)];
//    [dropdownMenu setMenuTitles:@[@"往往",@"朋友圈"] rowHeight:30];
//    dropdownMenu.delegate = self;
//    [self.view addSubview:dropdownMenu];
    
    
    WWCalourseView* calourse = [[WWCalourseView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [self.view addSubview:calourse];
    [calourse setDataSource:self];
    _calourse=calourse;
}

-(NSInteger)JE3DCalourseNumber
{
    return 3;
}
-(void)WWCalourseViewWith:(WWCalourseCell *)Cell andIndex:(NSInteger)index
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width + 60, 200)];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / 3.0 + 20, 200)];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 3.0 + 20, 0, self.view.bounds.size.width / 3.0 + 20, 200)];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 2 / 3.0 + 40, 0, self.view.bounds.size.width / 3.0 + 20, 200)];
    [view addSubview:imageView1];
    [view addSubview:imageView2];[view addSubview:imageView3];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    
    NSString *image_path1 = [resourcePath stringByAppendingPathComponent:@"gif_0.gif"];
    YYImage *image1 = [[YYImage alloc] initWithContentsOfFile:image_path1];
    imageView1.image = image1;
    
    NSString *image_path2 = [resourcePath stringByAppendingPathComponent:@"gif_1.gif"];
    YYImage *image2 = [[YYImage alloc] initWithContentsOfFile:image_path2];
    imageView1.image = image2;
    
    
    NSString *image_path3 = [resourcePath stringByAppendingPathComponent:@"gif_2.gif"];
    YYImage *image3 = [[YYImage alloc] initWithContentsOfFile:image_path3];
    imageView1.image = image3;
    
}

#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenuDidHidden:(WWDropDownMenu *)menu mainBtnTitle:(NSString *)title{
    NSLog(@"--已经隐藏--😘:%@",title);
}
-(void)testTEXTKit{
    self.edtingView = [[WWTagEditingView alloc]initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width-20, 200)];
    self.edtingView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.edtingView];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(kALScreenWidth / 4, kView_BOTTOMY(self.edtingView), kALScreenWidth / 2, 100)];
    self.textView.text = @"hellllll";
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    [self.view addSubview:self.textView];

    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 50, 200, 300);
    view.backgroundColor = [UIColor orangeColor];
    
    BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleCustomView
                                                      Title:@"hello"
                                                    message:@"Product_AlreadyAddedToShopCart"
                                                 customView:view
                                                   delegate:nil
                                          cancelButtonTitle:@"Confirm"
                                          otherButtonTitles:@"Product_GoToShopCart"];
    [alert show];
    [alert setConfirmBlock:^{
        
        ALAppLog(@"----hehe");
    }];
    [alert setCancelBlock:^{
        
    }];
    
    
//    self.edtingView = [[WWTagEditingView alloc]initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width-20, 200)];
//    self.edtingView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:self.edtingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
