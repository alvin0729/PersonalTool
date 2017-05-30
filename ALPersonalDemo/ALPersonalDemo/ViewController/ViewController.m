//
//  ViewController.m
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ViewController.h"
#import "ALNetWorkViewController.h"
#import "ALToastTableViewController.h"
#import "UIButton+SSAdd.h"

static NSArray *titles;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    //self.title = @"ALPersonalDemo";
    //self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view];
    view.frame = CGRectMake(50, 50, 45, 45);
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(70, 70, 5, 5);
    titleBtn.backgroundColor = [UIColor orangeColor];
    [titleBtn addTarget:self action:@selector(titleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //self.navigationItem.titleView = titleBtn;
    [self.view addSubview:titleBtn];
    [titleBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    
    //self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kALScreenWidth, kALScreenHeight - 100) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    titles = @[@"ALNetWorkViewController+网络数据类",@"ALToastTableViewController+提示加载"];
}

-(void)titleBtnAction{
    ALAppLog(@"===titleBtnAction===");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *vcStr = [titles[indexPath.row] componentsSeparatedByString:@"+"].firstObject;
    
    UIViewController *viewController = [[NSClassFromString(vcStr) class] new];
    [self.navigationController pushViewController:viewController animated:NO];
}



@end
