//
//  ALOC_Call_SwiftVC.m
//  ALPersonalDemo
//
//  Created by Alvin on 2017/11/13.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALOC_Call_SwiftVC.h"
#import "ALPersonalDemo-Swift.h"

@interface ALOC_Call_SwiftVC ()<ALEditTextFiledDelegate>

@end

@implementation ALOC_Call_SwiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    Test * test1 = [[Test alloc]init];
    [test1 test];
    
    SWView *view = [[SWView alloc]initWithFrame:CGRectMake(10, 120, 100, 100)];
    // OC访问Swift方法，需要加 `public`
    [view comeOn];
    [self.view addSubview:view];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ALTestSwiftVC *view = [[ALTestSwiftVC alloc]init];
    view.model = @"model-project";
    view.proId = @"hhahah";
    [view modeleWithModele:@"modle-func"];
    /**
     swift中的属性 可以使用set方法调用
     */
    [view setProId:@"model-project-100"];
    view.textfileddelegate = self;
    view.myeditBlock = ^(NSString * _Nonnull str) {
        
        NSLog(@"--------oc中通过block 接受到的参数:%@",str);
    };
    [self.navigationController pushViewController:view animated:YES];
    
}
/**
 调用swift中的代理方法
 */
- (void)editTextfiledDeleWithStr:(NSString *)str
{
    NSLog(@"=======oc中通过代理接受到的参数:%@",str);
}
@end
