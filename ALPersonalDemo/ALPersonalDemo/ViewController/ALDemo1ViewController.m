//
//  ALDemo1ViewController.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/1.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALDemo1ViewController.h"
#import "WWTagEditingView.h"

@interface ALDemo1ViewController ()
@property(nonatomic,strong)WWTagEditingView *edtingView;
@end

@implementation ALDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edtingView = [[WWTagEditingView alloc]initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width-20, 200)];
    self.edtingView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.edtingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
