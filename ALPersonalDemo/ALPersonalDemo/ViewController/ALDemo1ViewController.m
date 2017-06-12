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

@property (nonatomic,strong) UITextView *textView;

@end

@implementation ALDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
}


@end
