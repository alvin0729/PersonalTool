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

@interface ALDemo1ViewController ()<WWDropdownMenuDelegate>

@property(nonatomic,strong)WWTagEditingView *edtingView;

@property (nonatomic,strong) UITextView *textView;

@end

@implementation ALDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //MHYouKuTopicController *vc = [MHYouKuTopicController new];
    //[self.navigationController pushViewController:vc animated:NO];

    
    //HHInformationViewController *vc = [HHInformationViewController new];
    //[self.navigationController pushViewController:vc animated:NO];
    
    
//    ALRichTextDemoViewController *vc = [ALRichTextDemoViewController new];
//    [self.navigationController pushViewController:vc animated:NO];
    
//    ALRIchTextDemoViewControllernone *vc = [ALRIchTextDemoViewControllernone new];
//    [self.navigationController pushViewController:vc animated:NO];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    WWDropDownMenu * dropdownMenu = [[WWDropDownMenu alloc] init];
    [dropdownMenu setFrame:CGRectMake(20, 80, 100, 40)];
    [dropdownMenu setMenuTitles:@[@"往往",@"朋友圈"] rowHeight:30];
    dropdownMenu.delegate = self;
    [self.view addSubview:dropdownMenu];
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
