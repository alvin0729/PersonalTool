//
//  ALNetWorkViewController.m
//  ALPersonalDemo
//
//  Created by Alvin on 2017/5/28.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALNetWorkViewController.h"
#import "HYBNetworking.h"
#import "HttpTool.h"
#import "FileManagerHelper.h"


@interface ALNetWorkViewController ()

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSURLSessionDownloadTask *sessionDownloadTask;  // 下载Task
@property (nonatomic, strong) NSData *partialData;   // 下载的局部数据

@end

@implementation ALNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    self.partialData = [FileManagerHelper readDataWithFolder:nil andFile:[NSString stringWithFormat:@"user_jpg"] andSandBoxFolder:kUseDocumentTypeLibraryCaches];
    [self testDownloadDemo];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self suspend:nil];
}

#pragma mark - download
-(void)testDownloadDemo{
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 100, kALScreenWidth - 40, 10)];
    [self.view addSubview:self.progressView];
    [self download];
    
}
- (void)download {
    if (self.partialData) {
        [self resume:nil];
        return;
    }
    
    NSString *urlString = @"http://dlsw.baidu.com/sw-search-sp/soft/2a/25677/QQ_V4.1.1.1456905733.dmg";
    
    _sessionDownloadTask = [HttpTool download:urlString progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"download - %f", downloadProgress.fractionCompleted);
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressView.progress = downloadProgress.fractionCompleted;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"== %@ %@", filePath, error);
    }];
    
    [_sessionDownloadTask resume];
    
}

- (void)download_resume:(NSData *)data {
    
    _sessionDownloadTask = [HttpTool downloadTaskWithResumeData:data progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"download - %f", downloadProgress.fractionCompleted);
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressView.progress = downloadProgress.fractionCompleted;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"== %@ %@", filePath, error);
        
    }];
    
    [_sessionDownloadTask resume];
    
}

- (IBAction)begin:(id)sender {
    [self download];
}

- (IBAction)suspend:(id)sender {
    if (_sessionDownloadTask) {
        [_sessionDownloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            self.partialData = resumeData;
            [FileManagerHelper writeData:resumeData withFile:[NSString stringWithFormat:@"user_jpg"] andFolder:nil andSandBoxFolder:kUseDocumentTypeLibraryCaches];
        }];
    }
}

- (IBAction)resume:(id)sender {
    if (_partialData) {
        [self download_resume:_partialData];
        _partialData = nil;
    }
}

- (IBAction)cancel:(id)sender {
    [_sessionDownloadTask cancel];
    _sessionDownloadTask = nil;
    _partialData = nil;
    [_progressView setProgress:0.0 animated:NO];
}

#pragma mark - HYB

-(void)testHybDemo{
    // 通常放在appdelegate就可以了
    [HYBNetworking updateBaseUrl:@"http://apistore.baidu.com"];
    [HYBNetworking enableInterfaceDebug:YES];
    
    // 配置请求和响应类型，由于部分伙伴们的服务器不接收JSON传过去，现在默认值改成了plainText
    [HYBNetworking configRequestType:kHYBRequestTypePlainText
                        responseType:kHYBResponseTypeJSON
                 shouldAutoEncodeUrl:YES
             callbackOnCancelRequest:NO];
    
    /*
     [HYBNetworking.m：in line: 189]-->[message:
     absoluteUrl: http://apistore.baidu.com/microservice/cityinfo?cityname=%E5%8C%97%E4%BA%AC
     params:(null)
     response:{
     errNum = 0;
     retData =     {
     cityCode = 101010100;
     cityName = "\U5317\U4eac";
     provinceName = "\U5317\U4eac";
     telAreaCode = 010;
     zipCode = 100000;
     };
     retMsg = success;
     }
     ]
     */
    
    // 设置GET、POST请求都缓存
    [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];
    
    // 测试GET API
    NSString *url = @"http://api.map.baidu.com/telematics/v3/weather?location=嘉兴&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ";
    //   设置请求类型为text/html类型
    //  [HYBNetworking configRequestType:kHYBRequestTypePlainText];
    //  [HYBNetworking configResponseType:kHYBResponseTypeData];
    // 如果请求回来的数据是业务数据，但是是失败的，这时候需要外部开发人员才能判断是业务失败。
    // 内部处理是只有走failure的才能判断为无效数据，才不会缓存
    // 如果设置为YES,则每次会去刷新缓存，也就是不会读取缓存，即使已经缓存起来
    // 新下载的数据会重新缓存起来
    [HYBNetworking getWithUrl:url refreshCache:NO params:nil progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"progress: %f, cur: %lld, total: %lld",
              (bytesRead * 1.0) / totalBytesRead,
              bytesRead,
              totalBytesRead);
    } success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
    
    
    // 测试POST API：
    // 假数据
    NSDictionary *postDict = @{    @"urls": @"http://www.henishuo.com/git-use-inwork/",
                                   @"goal" : @"site",
                                   @"total" : @(123)
                                   };
    NSString *path = @"/urls?site=www.henishuo.com&token=bRidefmXoNxIi3Jp";
    // 由于这里有两套基础路径，用时就需要更新
    [HYBNetworking updateBaseUrl:@"http://data.zz.baidu.com"];
    // 每次刷新缓存
    // 如果获取到的业务数据是不正确的，则需要下次调用时设置为YES,表示要刷新缓存
    // HYBURLSessionTask *task =
    [HYBNetworking postWithUrl:path refreshCache:YES params:postDict success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
    
    // 取消全部请求
    //  [HYBNetworking cancelAllRequest];
    
    // 取消单个请求方法一
    //  [HYBNetworking cancelRequestWithURL:path];
    
    // 取消单个请求方法二
    //  [task cancel];
    
    NSLog(@"%lld", [HYBNetworking totalCacheSize]);
    //  [HYBNetworking clearCaches];
    
    path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/b.zip"];
    [HYBNetworking downloadWithUrl:@"http://wiki.lbsyun.baidu.com/cms/iossdk/sdk/BaiduMap_IOSSDK_v2.10.2_All.zip" saveToPath:path progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
    } success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
    //  NSLog(@"%@", task);
}

@end
