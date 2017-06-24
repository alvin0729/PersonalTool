//
//  ALRichTextDemoViewController.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/6/20.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALRichTextDemoViewController.h"
#import "SSRollingButtonScrollView.h"
#import "WWFontDownloadTask.h"
#import "ALFontManager.h"
#import "LxGridViewFlowLayout.h"
#import "UIView+TZLayout.h"
#import "TZTestCell.h"
#import "ALFontFile.h"
#import "HorizonScrollTableView.h"
#import "CategoryModel.h"
#import "CollectModel.h"

#import "ALPanToolView.h"

@interface ALRichTextDemoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HorizontalTableViewDelegate>{
    CGFloat _itemWH;
    CGFloat _margin;
}

@property (nonatomic, strong) NSDictionary *dataSourceDic;
@property (strong, nonatomic) NSMutableArray<ALFontFile *> *fontFiles;
@property (nonatomic, strong) UILabel *rightBtnLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *fontTitleArray;
@property (nonatomic, strong) NSMutableArray *fontDataSource;

@property (nonatomic, strong) ALPanToolView *toolView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ALRichTextDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSDictionary *fontsDictionary = @{@"报隶-简":kFontBaoli,
                                 @"冬青黑体-简":kFontDongqinghei,
                                 @"仿宋":kFontFaongsong,
                                 @"黑体":kFontBlack,
                                 @"黑体-简":kFontBlackJian,
                                 @"华文仿宋":kFontHWFangsong,
                                 @"华文黑体":kFontHWBlack,
                                 @"华文琥珀":kFontHWHupo,
                                 @"华文楷体":kFontHWKaiti,
                                 @"华文隶书":kFontHWLiti,
                                 @"华文宋体":kFontHWSong,
                                 @"华文新魏":kFontHWXinwei,
                                 @"华文行楷":kFontHWXingkai,
                                 @"华文中宋":kFontHWZhongsong,
                                 @"楷体":kFontKaiti,
                                 @"楷体-简":kFontKaitiJian,
                                 @"兰亭黑-简":kFontLTBlack,
                                 @"隶变-简":kFontLibianJian,
                                 @"翩翩体-简":kFontPianpian,
                                 @"苹方-简":kFontPingFang,
                                 @"手札体-简":kFontHannotate,
                                 @"宋体":kFontSongti,
                                 @"宋体-简":kFontSongtiJian,
                                 @"娃娃体-简":kFontWawa,
                                 @"微软雅黑":kFontMicrosoftYH,
                                 @"魏碑-简":kFontWeibei,
                                 @"行楷-简":kFontXingkai,
                                 @"雅痞-简":kFontYapi,
                                 @"圆体-简":kFontYuanti,
                                 @"GB18030 Bitmap":kFontGB18030,
                                 @"MingLiU":kFontMingLiU,
                                 @"MingLiU_HKSCS Regular":kFontMingLiUHKSCS,
                                 @"PMingLiU":kFontPMingLiU,
                                 @"SimSun-ExtB Regular":kFontSimSun,
                                 @"Adobe 仿宋":kFontAdobeFangsong,
                                 @"Adobe 黑体":kFontAdobeHeiti,
                                 @"Adobe 楷体":kFontAdobeKaiti,
                                 @"Adobe 宋体":kFontAdobeSongti
                                 };
    self.dataSourceDic = @{
                           @"Adobe 宋体":kFontAdobeSongti,
                           @"Adobe 宋体1":kFontAdobeSongti,
                           @"Adobe 宋体2":kFontAdobeSongti,
                           @"Adobe 宋体3":kFontAdobeSongti,
                           @"Adobe 宋体4":kFontAdobeSongti,
                           @"Adobe 宋体5":kFontAdobeSongti,
                           @"Adobe 宋体6":kFontAdobeSongti,
                           @"Adobe 宋体7":kFontAdobeSongti,
                           };
    self.fontTitleArray = @[@"Adobe 宋体",@"Adobe 宋体1",@"Adobe 宋体2",@"Adobe 宋体3",@"Adobe 宋体4",@"Adobe 宋体5",@"Adobe 宋体6",@"Adobe 宋体7"];
    self.fontDataSource = [NSMutableArray array];
    for (NSString *tittle in self.fontTitleArray) {
        TZModel *model = [[TZModel alloc] init];
        model.fontKeyName = tittle;
        model.fontValueName = self.dataSourceDic[tittle];
        [self.fontDataSource addObject:model];
    }
    
    
    [ALFontManager setFontNameStrings:self.dataSourceDic.allValues];
    self.fontFiles = [[ALFontManager fontFiles] mutableCopy];
    UIFont *mainFont = [ALFontManager mainFont];
    self.rightBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 84, 44)];
    self.rightBtnLabel.text = @"测试hello";
    self.rightBtnLabel.font = mainFont;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtnLabel];
    //[self configCollectionView];
    
    self.toolView = [[ALPanToolView alloc] initWithFrame:CGRectMake(0, 64, self.view.tz_width, 360)];
    [self.view addSubview:self.toolView];
    self.toolView.cateGoryArray = @[self.fontTitleArray,self.fontTitleArray,self.fontTitleArray,self.fontTitleArray];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutCellWithNotification:)
                                                 name:ALFontFileDownloadingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadRowWithNotification:)
                                                 name:ALFontFileDownloadingDidCompleteNotification
                                               object:nil];
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [ALFontManager archive];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.tz_width, 360) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fontFiles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    TZModel *model = self.fontDataSource[indexPath.row];
    cell.model = model;
    ALAppLog(@"T===%@",model.fontKeyName);
    ALFontFile *file = self.fontFiles[indexPath.row];
    if (file.downloadStatus == ALFontFileDownloadStateDownloaded) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor cyanColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ALFontFile *file = self.fontFiles[indexPath.row];
    switch (file.downloadStatus) {
        case ALFontFileDownloadStateToBeDownloaded: {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Download Font File From"
                                                                                     message:file.fontName
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                style:UIAlertActionStyleCancel
                                                              handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Start"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  [ALFontManager downloadFontFile:file];
                                                              }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case ALFontFileDownloadStateDownloading:break;
        case ALFontFileDownloadStateError:break;
        case ALFontFileDownloadStateDownloaded: {
            ALFontFile *model = self.fontFiles[indexPath.row];
            UIFont *font = [UIFont fontWithName:model.fontName size:12];
            self.rightBtnLabel.font = font;
            if ([font.fontName isEqualToString:[ALFontManager mainFont].fontName]) {
                [ALFontManager setMainFont:nil];
                [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            } else {
                [ALFontManager setMainFont:font];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < self.fontFiles.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < self.fontFiles.count && destinationIndexPath.item < self.fontFiles.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    ALFontFile *fontModel = self.fontFiles[sourceIndexPath.item];
    [self.fontFiles removeObjectAtIndex:sourceIndexPath.item];
    [self.fontFiles insertObject:fontModel atIndex:destinationIndexPath.item];
    
    [_collectionView reloadData];
}

#pragma mark - Notification

- (void)layoutCellWithNotification:(NSNotification *)notification {
    ALFontFile *file = [notification.userInfo objectForKey:ALFontFileNotificationUserInfoKey];
    NSInteger targetRow = [self.fontFiles indexOfObject:file];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:targetRow inSection:0];
    if ([self.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
        TZTestCell *cell = (TZTestCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.downloadProgress = file.downloadProgress;
        [cell setNeedsLayout];
    }
}

- (void)reloadRowWithNotification:(NSNotification *)notification {
    ALFontFile *file = [notification.userInfo objectForKey:ALFontFileNotificationUserInfoKey];
    NSInteger targetRow = [self.fontFiles indexOfObject:file];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:targetRow inSection:0];
    if ([self.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
        TZTestCell *cell = (TZTestCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.downloadProgress = file.downloadProgress;
        [cell setNeedsLayout];
        ALAppLog(@"----------------------------------");
        ALAppLog(@"----------------------------------");
        ALAppLog(@"----------------------------------");
        self.rightBtnLabel.font = [UIFont fontWithName:file.fontName size:14];
    }
}

@end
