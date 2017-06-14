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

@interface ALDemo1ViewController ()
@property(nonatomic,strong)WWTagEditingView *edtingView;
@end

@implementation ALDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
