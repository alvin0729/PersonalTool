//
//  ALReactiveCocoaDemoVC.m
//  ALPersonalDemo
//
//  Created by Alvin on 2017/6/10.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALReactiveCocoaDemoVC.h"
#import "ReactiveCocoa.h" 

static NSArray *dataSource;

@interface ALReactiveCocoaDemoVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *valueA;
@property (nonatomic,copy) NSString *valueB;

@end

@implementation ALReactiveCocoaDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:view];
//    view.frame = CGRectMake(50, 50, 45, 45);
    
    //self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, kALScreenWidth, kALScreenHeight - 80) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    dataSource = @[@"1.监听",
                   @"2.单边 你唱歌 我就跳舞",
                   @"3.双边",
                   @"4.通知",
                   @"5.连接依赖 先 恋爱 后 结婚",
                   @"6.合并 两个厂的污水流到一个污水厂处理",
                   @"7.组合套餐 你是红的，我是黄的，我们就是红黄的，你是白的，我没变，我们是白黄的",
                   @"8.压缩 你是红的，我是黄的，我们就是红黄的，你是白的，我没变，哦，那就等我变了再说",
                   @"9.映射 点石头成金",
                   @"10.归约  糖加水变成糖水",
                   @"11.过滤 未满是十八岁禁止入内",
                   @"12.扁平  打蛋液，煎鸡蛋，上盘 （每步都可以传质值）",
                   @"13.次序  把大象塞进冰箱只需要三步：打开冰箱门，把大象塞进冰箱，关上冰箱门 (不传值)",
                   @"14.命令  我命令你马上投降",
                   @"15.延迟 等等我还有一分钟我就到了",
                   @"16.重放 一次制作 重复观看",
                   @"17.定时 每3秒服药一次",
                   @"18.超时 等了你一个小时了，你还没来，我走了",
                   @"19.重试 成功之前可能需要数百次失败",
                   @"20.节流 不好意意思 这一秒只能通过一个人",
                   @"21.条件 直到世界的尽头才能把我们分开 "];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 1.监听
    if (indexPath.row == 0) {
        [self.nameTF.rac_textSignal subscribeNext:^(id x) {
            NSLog(@"textFiel的改变:%@",x);
        }];
        
        [RACObserve(self, age) subscribeNext:^(id x) {
            NSLog(@"监听值x的改变:%@",x);
        }];
    }
    
    
    // 2.单边 你唱歌 我就跳舞  **不能重复createSignal**
    if (indexPath.row == 1) {
        RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"唱歌"];
            return nil;
        }];
        RAC(self,name) = [signalA map:^id(id value) {
            if ([value isEqualToString:@"唱歌"]) {
                return @"跳舞";
            }
            return @"";
            
        }];
        NSLog(@"self.name = %@",self.name);
    }
    
    
    // 3.双边
    if (indexPath.row == 2) {
        RACChannelTerminal *chanlA = RACChannelTo(self,valueA);
        RACChannelTerminal *chanlB = RACChannelTo(self,valueB);
        [[chanlA map:^id(id value) {
            if ([value isEqualToString:@"东"]) {
                return @"西";
            }
            return value;
        }] subscribe:chanlB];
        
        [[chanlB map:^id(id value) {
            if ([value isEqualToString:@"左"]) {
                return @"右";
            }
            return value;
        }] subscribe:chanlA];
        
        [[RACObserve(self, valueA) filter:^BOOL(id value) {
            return value ? YES : NO;
        }] subscribeNext:^(id x) {
            NSLog(@"你向%@",x);
        }];
        
        [[RACObserve(self, valueB) filter:^BOOL(id value) {
            return value ? YES : NO;
        }] subscribeNext:^(id x) {
            NSLog(@"他向%@",x);
        }];
        self.valueA = @"东";
        self.valueB = @"左";
    }
    
    
    // 4.通知
    if (indexPath.row == 3) {
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"通知" object:nil] subscribeNext:^(NSNotification *x) {
            NSLog(@"技巧:%@",x.userInfo);
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"通知" object:nil userInfo:@{@"技巧":@"iOS"}];
    }
    
    
    // 5.连接依赖 先 恋爱 后 结婚
    if (indexPath.row == 4) {
        RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"我结婚啦"];
            [subscriber sendCompleted];
            return nil;
        }];
        
        RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"我恋爱了"];
            [subscriber sendCompleted];
            return nil;
        }];
        
        [[signal2 concat:signal1] subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }
   
    
    // 6.合并 两个厂的污水流到一个污水厂处理
    if (indexPath.row == 5) {
        RACSignal *signal3 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"纸厂污水"];
            return nil;
        }];
        RACSignal *signal4 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"化工厂污水"];
            return nil;
        }];
        
        [[RACSignal merge:@[signal3,signal4]] subscribeNext:^(id x) {
            NSLog(@"处理%@",x);
        }];
    }
    
    
    // 7.组合套餐 你是红的，我是黄的，我们就是红黄的，你是白的，我没变，我们是白黄的
    if (indexPath.row == 6) {
        RACSignal *signal5 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"绿"];
            [subscriber sendNext:@"黑"];
            return nil;
        }];
        
        RACSignal *signal6 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"白"];
            return nil;
        }];
        
        [[RACSignal combineLatest:@[signal5,signal6]] subscribeNext:^(RACTuple *x) {
            RACTupleUnpack(NSString *strA,NSString*strB) = x;
            NSLog(@"组合:我们是%@%@",strA,strB);
        }];
    }
    
    
    
    // 8.压缩 你是红的，我是黄的，我们就是红黄的，你是白的，我没变，哦，那就等我变了再说
    if (indexPath.row == 7) {
        RACSignal *signal7 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"绿"];
            [subscriber sendNext:@"黑"];
            return nil;
        }];
        
        RACSignal *signal8 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"白"];
            return nil;
        }];
        
        [[RACSignal zip:@[signal7,signal8]] subscribeNext:^(RACTuple *x) {
            RACTupleUnpack(NSString *strA,NSString *strB) = x;
            NSLog(@"压缩:我们是%@%@",strA,strB);
        }];
    }
    
    
    // 9.映射 点石头成金
    if (indexPath.row == 8) {
        RACSignal *signal10 = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"石头"];
            return nil;
        }] map:^id(id value) {
            if ([value isEqualToString:@"石头"]) {
                return @"金子";
            }
            return value;
        }];
        [signal10 subscribeNext:^(id x) {
            NSLog(@"石头成%@",x);
        }];
    }
    
    
    
    // 10.归约  糖加水变成糖水
    if (indexPath.row == 9) {
        RACSignal *sugarSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"糖"];
            return nil;
        }];
        RACSignal *waterSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"水"];
            return nil;
        }];
        
        [[RACSignal combineLatest:@[sugarSignal,waterSignal] reduce:^id(NSString *sugar,NSString *water){
            return [sugar stringByAppendingString:water];
        }] subscribeNext:^(id x) {
            NSLog(@"糖加水变成:%@",x);
        }];
    }
    
    
    // 11.过滤 未满是十八岁禁止入内
    if (indexPath.row == 10) {
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@(10)];
            [subscriber sendNext:@(19)];
            return nil;
        }] filter:^BOOL(id value) {
            return [value integerValue] > 18;
        }] subscribeNext:^(id x) {
            NSLog(@"%@岁可以入内",x);
        }];
    }
   
    
    // 12.扁平  打蛋液，煎鸡蛋，上盘 （每步都可以传质值）
    if (indexPath.row == 11) {
        [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"打蛋液");
            [subscriber sendNext:@"打蛋液"];
            [subscriber sendCompleted];
            return nil;
        }] flattenMap:^RACStream *(id value) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"把%@倒进锅里煎",value);
                [subscriber sendNext:@"煎蛋"];
                [subscriber sendCompleted];
                return nil;
            }];
            
        }] flattenMap:^RACStream *(id value) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"把%@装到盘里",value);
                [subscriber sendNext:@"上菜"];
                [subscriber sendCompleted];
                return nil;
            }];
        }] subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }
    
    
    // 13.次序  把大象塞进冰箱只需要三步：打开冰箱门，把大象塞进冰箱，关上冰箱门 (不传值)
    if (indexPath.row == 12) {
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"打开冰箱");
            [subscriber sendCompleted];
            return nil;
        }] then:^RACSignal *{
            return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"把大象放进去");
                [subscriber sendCompleted];
                return nil;
            }] then:^RACSignal *{
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    NSLog(@"关上冰箱门");
                    [subscriber sendCompleted];
                    return nil;
                }];
            }];
        }] subscribeCompleted:^{
            NSLog(@"完成任务");
        }];
    }
    
    
    // 14.命令  我命令你马上投降
    if (indexPath.row == 13) {
        RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"我投降了");
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        [command execute:nil];
    }
    
    
    // 15.延迟 等等我还有一分钟我就到了
    if (indexPath.row == 14) {
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"等我下还有3妙");
            [subscriber sendNext:@"我到了"];
            [subscriber sendCompleted];
            return nil;
        }] delay:3] subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }
    
    
    // 16.重放 一次制作 重复观看
    if (indexPath.row == 15) {
        RACSignal *signalReplay = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"大导演拍了一部电影《我的男票是程序员》");
            [subscriber sendNext:@"《我的男票是程序员》"];
            return nil;
        }] replay];
        
        [signalReplay subscribeNext:^(id x) {
            NSLog(@"小明看了%@",x);
        }];
        [signalReplay subscribeNext:^(id x) {
            NSLog(@"小王看了%@",x);
        }];
    }
    
    
    // 17.定时 每3秒服药一次  **注意释放**
    if (indexPath.row == 16) {
        [[RACSignal interval:3 onScheduler:[RACScheduler mainThreadScheduler]]
         subscribeNext:^(id x) {
             NSLog(@"吃药了");
         }];
    }
    
    
    // 18.超时 等了你一个小时了，你还没来，我走了
    if (indexPath.row == 17) {
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"我快到了");
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                return nil;
            }] delay:5] subscribeNext:^(id x) {
                NSLog(@"5秒钟到");
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }];
            return nil;
        }] timeout:3 onScheduler:[RACScheduler mainThreadScheduler]] subscribeError:^(NSError *error) {
            NSLog(@"我等了3秒你还没来，我先走啦");
        }];
    }
    
    
    // 19.重试 成功之前可能需要数百次失败
    if (indexPath.row == 18) {
        __block int failedCount = 0;
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if (failedCount < 10) {
                failedCount++;
                NSLog(@"我失败了");
                [subscriber sendError:nil];
            }else{
                NSLog(@"经历了数10次失败后");
                [subscriber sendNext:nil];
            }
            return nil;
        }] retry] subscribeNext:^(id x) {
            NSLog(@"终于成功了");
        }];
    }
    
    
    // 20.节流 不好意意思 这一秒只能通过一个人
    if (indexPath.row == 19) {
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"旅客A"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"旅客C"];
                [subscriber sendNext:@"旅客D"];
                [subscriber sendNext:@"旅客E"];
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"旅客F"];
            });
            
            return nil;
        }] throttle:1] subscribeNext:^(id x) {
            NSLog(@"通过了%@",x);
        }];
    }
    
    
    // 21.条件 直到世界的尽头才能把我们分开
    if (indexPath.row == 20) {
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
                [subscriber sendNext:@"直到世界的尽头才能把我们分开"];
            }];
            return nil;
        }] takeUntil:[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"世界的尽头到了");
                [subscriber sendNext:@"世界的尽头到了"];
            });
            return nil;
        }]] subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.age++;
}

-(void)dealloc{
    ALAppLog(@"___%s___",__FUNCTION__);
}

@end
