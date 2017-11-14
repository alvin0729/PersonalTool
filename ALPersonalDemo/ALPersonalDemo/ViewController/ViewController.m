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
#import <CommonCrypto/CommonDigest.h>
#import "ALOC_Call_SwiftVC.h"

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
    
    
    titles = @[@"ALNetWorkViewController+网络数据类",@"ALToastTableViewController+提示加载",@"ALReactiveCocoaDemoVC+RAC",@"ALDemo1ViewController+暂时显示",@"ALOC_Call_SwiftVC+oc-调用swift"];
    [FileManagerHelper deleteObjectWithFile:[NSString stringWithFormat:@"user_jpg"]  folder:nil sandBoxFolder:kUseDocumentTypeLibraryCaches];
    
    /**单词排序*/
    NSString *randomString = [self randomStringWithLength:5];
    /**结束面聊*/
    //NSDictionary *params =  @{@"recordId":@(10041),@"payChannels":@"diamond",@"nonceStr":randomString};
    /**面聊中扣费*/
    NSDictionary *params =  @{@"recordId":@(10041),@"timeLeng":@(90),@"diamond":@(1000),@"payChannels":@"diamond",@"nonceStr":randomString,@"v":@"2.0"};
    NSArray *paramsArr = params.allKeys;
    NSArray *arr = [NSArray array];
    arr = [paramsArr sortedArrayUsingSelector:@selector(compare:)];
    NSString *firstStr = @"";
    for (int i = 0; i < arr.count; i++) {
        NSString *key = arr[i];
        NSString *value = params[key];
        if (![value isKindOfClass:[NSString class]]) {
            if ([value isKindOfClass:[NSNumber class]]) {
                value = [NSString stringWithFormat:@"%d",[params[key] intValue]];
            }
        }
        if (0 == i) {
            firstStr = [NSString stringWithFormat:@"%@=%@",key,value];
        }else{
            firstStr = [NSString stringWithFormat:@"%@&%@=%@",firstStr,key,value];
        }
    }
    NSString *secondStr = [NSString stringWithFormat:@"%@&%@&%@",randomString,firstStr,randomString];
    NSString *thirdStr = [self payMD5:@"javaapp"];
    NSString *fourthStr = [NSString stringWithFormat:@"%@&%@&%@",thirdStr,secondStr,thirdStr];
    NSString *signStr = [self payMD5:fourthStr];
    NSLog(@"signStr:%@",signStr);
    NSMutableDictionary *backDic = params.mutableCopy;
    [backDic setValue:signStr forKey:@"signature"];
    for (NSString *key in backDic.allKeys) {
        NSLog(@"key:%@====value:%@",key,backDic[key]);
    }
    
    
//    [self testDemo3];
//    while (1)
//    {
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:20]];
//        NSLog(@"exiting runloop.........:");
//    }
    
}

- (NSString *)randomStringWithLength:(int)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i = 0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

- (NSString *)payMD5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建监听者
    /*
     第一个参数 CFAllocatorRef allocator：分配存储空间 CFAllocatorGetDefault()默认分配
     第二个参数 CFOptionFlags activities：要监听的状态 kCFRunLoopAllActivities 监听所有状态
     第三个参数 Boolean repeats：YES:持续监听 NO:不持续
     第四个参数 CFIndex order：优先级，一般填0即可
     第五个参数 ：回调 两个参数observer:监听者 activity:监听的事件
     */
    /*
     所有事件
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),   //   即将进入RunLoop
     kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理Timer
     kCFRunLoopBeforeSources = (1UL << 2), // 即将处理Source
     kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠
     kCFRunLoopAfterWaiting = (1UL << 6),// 刚从休眠中唤醒
     kCFRunLoopExit = (1UL << 7),// 即将退出RunLoop
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     };
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    
    // 给RunLoop添加监听者
    /*
     第一个参数 CFRunLoopRef rl：要监听哪个RunLoop,这里监听的是主线程的RunLoop
     第二个参数 CFRunLoopObserverRef observer 监听者
     第三个参数 CFStringRef mode 要监听RunLoop在哪种运行模式下的状态
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    /*
     CF的内存管理（Core Foundation）
     凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
     GCD本来在iOS6.0之前也是需要我们释放的，6.0之后GCD已经纳入到了ARC中，所以我们不需要管了
     */
    CFRelease(observer);
}


@end
