//
//  ViewController.m
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ViewController.h"
#import "ALNetWorkViewController.h"

static NSArray *titles;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ALPersonalDemo";
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    titles = @[@"ALNetWorkViewController+网络数据类"];
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
