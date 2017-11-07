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
#import "ALDemo1ViewController.h"
#import "ALReactiveCocoaDemoVC.h"
#import "FileManagerHelper.h"

static NSArray *titles;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate,NSPortDelegate>
{
    NSInteger count;
}
@property (nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSThread *thread;
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
    
    titles = @[@"ALNetWorkViewController+网络数据类",@"ALToastTableViewController+提示加载",@"ALReactiveCocoaDemoVC+RAC",@"ALDemo1ViewController+暂时显示"];
    [FileManagerHelper deleteObjectWithFile:[NSString stringWithFormat:@"user_jpg"]  folder:nil sandBoxFolder:kUseDocumentTypeLibraryCaches];
    [self testDemo3];
    while (1)
    {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        NSLog(@"exiting runloop.........:");
    }
    
}
- (void)testDemo1
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"线程开始");
        //获取到当前线程
        self.thread = [NSThread currentThread];
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        //添加一个Port，同理为了防止runloop没事干直接退出
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        
        //运行一个runloop，[NSDate distantFuture]：很久很久以后才让它失效
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        NSLog(@"线程结束");
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //在我们开启的异步线程调用方法
        [self performSelector:@selector(recieveMsg) onThread:self.thread withObject:nil waitUntilDone:NO];
    });
}

- (void)recieveMsg
{
    NSLog(@"收到消息了，在这个线程：%@",[NSThread currentThread]);
}

- (void)testDemo2
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"starting thread.......");
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(doTimerTask1:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        //最后一个参数，是否处理完事件返回,结束runLoop
        SInt32 result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 100, YES);
        /*
         kCFRunLoopRunFinished = 1, //Run Loop结束，没有Timer或者其他Input Source
         kCFRunLoopRunStopped = 2, //Run Loop被停止，使用CFRunLoopStop停止Run Loop
         kCFRunLoopRunTimedOut = 3, //Run Loop超时
         kCFRunLoopRunHandledSource = 4 ////Run Loop处理完事件，注意Timer事件的触发是不会让Run Loop退出返回的，即使CFRunLoopRunInMode的第三个参数是YES也不行
         */
        switch (result) {
            case kCFRunLoopRunFinished:
                NSLog(@"kCFRunLoopRunFinished");
                
                break;
            case kCFRunLoopRunStopped:
                NSLog(@"kCFRunLoopRunStopped");
                
            case kCFRunLoopRunTimedOut:
                NSLog(@"kCFRunLoopRunTimedOut");
                
            case kCFRunLoopRunHandledSource:
                NSLog(@"kCFRunLoopRunHandledSource");
            default:
                break;
        }
        
        NSLog(@"end thread.......");
        
    });
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"0000000");
}

- (void)doTimerTask1:(NSTimer *)timer
{
    
    count++;
    if (count == 10) {
        [timer invalidate];
    }
    NSLog(@"do timer task count:%d",count);
}

- (void)testDemo3
{
    //声明两个端口   随便怎么写创建方法，返回的总是一个NSMachPort实例
    NSMachPort *mainPort = [[NSMachPort alloc]init];
    NSPort *threadPort = [NSMachPort port];
    //设置线程的端口的代理回调为自己
    threadPort.delegate = self;
    
    //给主线程runloop加一个端口
    [[NSRunLoop currentRunLoop]addPort:mainPort forMode:NSDefaultRunLoopMode];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //添加一个Port
        [[NSRunLoop currentRunLoop]addPort:threadPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    });
    
    NSString *s1 = @"hello";
    
    NSData *data = [s1 dataUsingEncoding:NSUTF8StringEncoding];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[mainPort,data]];
        //过2秒向threadPort发送一条消息，第一个参数：发送时间。msgid 消息标识。
        //components，发送消息附带参数。reserved：为头部预留的字节数（从官方文档上看到的，猜测可能是类似请求头的东西...）
        [threadPort sendBeforeDate:[NSDate date] msgid:1000 components:array from:mainPort reserved:0];
        
    });
    
}

//这个NSMachPort收到消息的回调，注意这个参数，可以先给一个id。如果用文档里的NSPortMessage会发现无法取值
- (void)handlePortMessage:(id)message
{
    
    NSLog(@"收到消息了，线程为：%@",[NSThread currentThread]);
    
    //只能用KVC的方式取值
    NSArray *array = [message valueForKeyPath:@"components"];
    
    NSData *data =  array[1];
    NSString *s1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",s1);
    
    //    NSMachPort *localPort = [message valueForKeyPath:@"localPort"];
    //    NSMachPort *remotePort = [message valueForKeyPath:@"remotePort"];
    
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
    
    if ([vcStr isEqualToString:@"ALReactiveCocoaDemoVC"]) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        ALReactiveCocoaDemoVC *childController = [board instantiateViewControllerWithIdentifier: @"ALReactiveCocoaDemoVC"];
        [self.navigationController pushViewController:childController animated:NO];
        return;
    }
    
    UIViewController *viewController = [[NSClassFromString(vcStr) class] new];
    [self.navigationController pushViewController:viewController animated:NO];
}



@end
