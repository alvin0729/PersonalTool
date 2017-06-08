//#import "WWAlbumPreviewViewController.h"
//@interface WWAlbumPreviewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
//    UIImageView *navBarHairlineImageView;
//}
//@property (strong, nonatomic) UICollectionView *collectionView;
//@property (strong, nonatomic) UILabel *titleLb;
//@property (strong, nonatomic) UIButton *rightBtn;
//@property (strong, nonatomic) UIButton *albumBtn;
//@property (strong, nonatomic) UIButton *photographBtn;
//@property (strong, nonatomic) HXPhotoPreviewViewCell *livePhotoCell;
//@property (assign, nonatomic) NSInteger index;
//@end
//
//@implementation WWAlbumPreviewViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.manager = [HXPhotoManager sharedManager];
//    [self setup];
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
//    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
//    navBarHairlineImageView.hidden = YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    navBarHairlineImageView.hidden = YES;
//    [[WWPreviousNavBarAppearance sharepreviousNavBarAppearance] restorePreviousNavBarAppearance:animated vc:self];
//}
//
//- (void)setup
//{
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationItem.titleView = self.titleLb;
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBarBtn setImage:[UIImage imageNamed:@"bianji_Close"] forState:UIControlStateNormal];
//    leftBarBtn.frame = CGRectMake(0, 0, 30, 30);
//    [leftBarBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
//    
//    
//    CGFloat width = self.view.frame.size.width;
//    CGFloat height = self.view.frame.size.height;
//    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(width, height);
//    flowLayout.minimumInteritemSpacing = 0;
//    flowLayout.minimumLineSpacing = 20;
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, width + 20, height) collectionViewLayout:flowLayout];
//    collectionView.backgroundColor = [UIColor whiteColor];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    collectionView.pagingEnabled = YES;
//    collectionView.showsVerticalScrollIndicator = NO;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    collectionView.contentSize = CGSizeMake(self.manager.selectedList.count * (width + 20), 0);
//    [collectionView registerClass:[HXPhotoPreviewViewCell class] forCellWithReuseIdentifier:@"cellId"];
//    [self.view addSubview:collectionView];
//    self.collectionView = collectionView;
//    [collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
//    self.index = 0;
//    self.albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.albumBtn setTitle:@"重新选择" forState:UIControlStateNormal];
//    [self.albumBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    self.albumBtn.titleLabel.font = DDPingFangSCMediumFONT(15);
//    [self.albumBtn addTarget:self action:@selector(reChoosePhotos:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    self.albumBtn.frame = CGRectMake((SCREEN_WIDTH - 230) / 3, SCREEN_HEIGHT - 78, 115, 34);
//    self.albumBtn.layer.borderWidth = 1;
//    self.albumBtn.layer.cornerRadius = 17;
//    self.albumBtn.layer.masksToBounds = YES;
//    self.albumBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    [self.view addSubview:self.albumBtn];
//    
//    self.photographBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.photographBtn setTitle:@"使用照片" forState:UIControlStateNormal];
//    [self.photographBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.photographBtn.titleLabel.font = DDPingFangSCMediumFONT(15);
//    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:115/255.0 green:111/255.0 blue:251/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:119/255.0 green:167/255.0 blue:247/255.0 alpha:1].CGColor];
//    gradientLayer.locations = @[@0.1, @0.9];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1.0, 0);
//    gradientLayer.frame = CGRectMake(0, 0, 115, 34);
//    [self.photographBtn.layer insertSublayer:gradientLayer below:self.photographBtn.titleLabel.layer];
//    
//    
//    
//    [self.photographBtn addTarget:self action:@selector(useSelectedPhoto:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.photographBtn.frame = CGRectMake(2 * (SCREEN_WIDTH - 230) / 3 + 115, SCREEN_HEIGHT - 78, 115, 34);
//    self.photographBtn.layer.cornerRadius = 17;
//    self.photographBtn.layer.masksToBounds = YES;
//    [self.view addSubview:self.photographBtn];
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.manager.selectedList.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    HXPhotoPreviewViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
//    cell.model = self.manager.selectedList[indexPath.item];
//    return cell;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat width = self.view.frame.size.width;
//    CGFloat offsetx = scrollView.contentOffset.x;
//    NSInteger currentIndex = (offsetx + (width + 20) * 0.5) / (width + 20);
//    self.titleLb.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex + 1,self.manager.selectedList.count];
//    self.index = currentIndex;
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    HXPhotoModel *model = self.manager.selectedList[self.index];
//    if (model.isCloseLivePhoto) {
//        return;
//    }
//    if (self.livePhotoCell) {
//        [self.livePhotoCell stopLivePhoto];
//    }
//    HXPhotoPreviewViewCell *cell = (HXPhotoPreviewViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0]];
//    if (model.type == HXPhotoModelMediaTypeLivePhoto) {
//        [cell startLivePhoto];
//        self.livePhotoCell = cell;
//    }else if (model.type == HXPhotoModelMediaTypePhotoGif) {
//        [cell startGifImage];
//    }else {
//        [cell fetchLongPhoto];
//    }
//}
//
//- (UILabel *)titleLb
//{
//    if (!_titleLb) {
//        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
//        _titleLb.textColor = [UIColor blackColor];
//        _titleLb.font = [UIFont boldSystemFontOfSize:17];
//        _titleLb.textAlignment = NSTextAlignmentCenter;
//        _titleLb.text = [NSString stringWithFormat:@"%ld/%ld",self.index + 1,self.manager.selectedList.count];
//    }
//    return _titleLb;
//}
//#pragma mark - SEL
//-(void)reChoosePhotos:(UIButton *)sender{
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[HXPhotoViewController class]]) {
//            HXPhotoViewController *VC =(HXPhotoViewController *)controller;
//            [self.navigationController popToViewController:VC animated:YES];
//        }
//    }
//}
//
//-(void)useSelectedPhoto:(UIButton *)sender{
//    WWPublishTalkViewController *talkVC = [[WWPublishTalkViewController alloc] init];
//    [self.navigationController pushViewController:talkVC animated:NO];
//}
//
//- (void)cancelClick{
//    if (self.livePhotoCell) {
//        [self.livePhotoCell stopLivePhoto];
//    }
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[HXPhotoViewController class]]) {
//            HXPhotoViewController *VC =(HXPhotoViewController *)controller;
//            [self.navigationController popToViewController:VC animated:YES];
//        }
//    }
//}
//
//- (void)didNextClick:(UIButton *)button
//{
//    HXPhotoModel *model = self.manager.selectedList[self.index];
//    BOOL max = NO;
//    if (self.manager.selectedList.count == self.manager.maxNum) {
//        max = YES;
//    }
//    if (self.manager.type == HXPhotoManagerSelectedTypePhotoAndVideo) {
//        if ((model.type == HXPhotoModelMediaTypePhoto || model.type == HXPhotoModelMediaTypePhotoGif) || (model.type == HXPhotoModelMediaTypeCameraPhoto || model.type == HXPhotoModelMediaTypeLivePhoto)) {
//            if (self.manager.videoMaxNum > 0) {
//                if (!self.manager.selectTogether) {
//                    if (self.manager.selectedVideos.count > 0 ) {
//                        max = YES;
//                    }
//                }
//            }
//            if (self.manager.selectedPhotos.count == self.manager.photoMaxNum) {
//                max = YES;
//            }
//        }
//    }else if (self.manager.type == HXPhotoManagerSelectedTypePhoto) {
//        if (self.manager.selectedPhotos.count == self.manager.photoMaxNum) {
//            max = YES;
//        }
//    }
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    HXPhotoModel *model = self.manager.selectedList[self.index];
//    if (model.isCloseLivePhoto) {
//        return;
//    }
//    HXPhotoPreviewViewCell *cell = (HXPhotoPreviewViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0]];
//    if (model.type == HXPhotoModelMediaTypeLivePhoto) {
//        [cell startLivePhoto];
//        self.livePhotoCell = cell;
//    }else if (model.type == HXPhotoModelMediaTypePhotoGif) {
//        [cell startGifImage];
//    }else {
//        [cell fetchLongPhoto];
//    }
//}
//
//- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
//    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
//        return (UIImageView *)view;
//    }
//    for (UIView *subview in view.subviews) {
//        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
//        if (imageView) {
//            return imageView;
//        }
//    }
//    return nil;
//}
//@end
//#import "PhotoViewController.h"
//@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,AlbumListViewDelegate,PhotoPreviewViewControllerDelegate,PhotoBottomViewDelegate,CameraViewControllerDelegate,PhotoViewCellDelegate,UIAlertViewDelegate,FullScreenCameraViewControllerDelegate>
//{
//    CGRect _originalFrame;
//    UIImageView *navBarHairlineImageView;
//}
//@property (strong, nonatomic) NSMutableArray *photos;
//@property (copy, nonatomic) NSArray *albums;
//@property (weak, nonatomic) HXAlbumListView *albumView;
//@property (weak, nonatomic) HXAlbumTitleButton *titleBtn;
//@property (strong, nonatomic) UIButton *rightBtn;
//@property (strong, nonatomic) UIView *albumsBgView;
//@property (weak, nonatomic) HXPhotoBottomView *bottomView;
//@property (strong, nonatomic) NSMutableArray *videos;
//@property (strong, nonatomic) NSMutableArray *objs;
//@property (strong, nonatomic) UIActivityIndicatorView *indica;
//@property (assign, nonatomic) BOOL isSelectedChange;
//@property (strong, nonatomic) HXAlbumModel *albumModel;
//@property (assign, nonatomic) NSInteger currentSelectCount;
//@property (strong, nonatomic) NSIndexPath *currentIndexPath;
//@property (strong, nonatomic) UIImageView *previewImg;
//@property (strong, nonatomic) NSTimer *timer;
//@property (strong, nonatomic) UILabel *authorizationLb;
//@end
//
//@implementation HXPhotoViewController
//
//- (UILabel *)authorizationLb
//{
//    if (!_authorizationLb) {
//        _authorizationLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
//        _authorizationLb.text = @"无法访问照片\n请点击这里前往设置中允许访问照片";
//        _authorizationLb.textAlignment = NSTextAlignmentCenter;
//        _authorizationLb.numberOfLines = 0;
//        _authorizationLb.textColor = [UIColor blackColor];
//        _authorizationLb.font = [UIFont systemFontOfSize:15];
//        _authorizationLb.userInteractionEnabled = YES;
//        [_authorizationLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSetup)]];
//    }
//    return _authorizationLb;
//}
//- (void)goSetup
//{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [[WWPreviousNavBarAppearance sharepreviousNavBarAppearance] storePreviousNavBarAppearance:self];
//    [self setup];
//    [self getObjs];
//    
//    if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized) {
//        [self.view addSubview:self.authorizationLb];
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(observeAuthrizationStatusChange:) userInfo:nil repeats:YES];
//    }else{
//        [self goCameraVC];
//    }
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self setNavBarAppearance:animated];
//    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
//    navBarHairlineImageView.hidden = NO;
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    self.bottomView.albumBtn.selected = YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    navBarHairlineImageView.hidden = YES;
//    [[WWPreviousNavBarAppearance sharepreviousNavBarAppearance] restorePreviousNavBarAppearance:animated vc:self];
//}
//
//- (void)observeAuthrizationStatusChange:(NSTimer *)timer
//{
//    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
//        [timer invalidate];
//        self.timer = nil;
//        [self.authorizationLb removeFromSuperview];
//        [self goCameraVC];
//        [self getObjs];
//    }
//}
//
//- (void)goCameraVC
//{
//    if (self.manager.goCamera) {
//        self.manager.goCamera = NO;
//        if (!self.manager.openCamera) {
//            return;
//        }
//        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            [self.view showImageHUDText:@"此设备不支持相机!"];
//            return;
//        }
//        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
//            [alert show];
//            return;
//        }
//        HXCameraViewController *vc = [[HXCameraViewController alloc] init];
//        vc.delegate = self;
//        if (self.manager.type == HXPhotoManagerSelectedTypePhotoAndVideo) {
//            vc.type = HXCameraTypePhotoAndVideo;
//        }else if (self.manager.type == HXPhotoManagerSelectedTypePhoto) {
//            vc.type = HXCameraTypePhoto;
//        }else if (self.manager.type == HXPhotoManagerSelectedTypeVideo) {
//            vc.type = HXCameraTypeVideo;
//        }
//        [self presentViewController:vc animated:YES completion:nil];
//    }
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
//}
//
//- (void)getObjs
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        __weak typeof(self) weakSelf = self;
//        BOOL isShow = self.manager.selectedList.count;
//        [self.manager FetchAllAlbum:^(NSArray *albums) {
//            weakSelf.albums = albums;
//            HXAlbumModel *model = weakSelf.albums.firstObject;
//            weakSelf.currentSelectCount = model.selectedCount;
//            weakSelf.albumModel = model;
//            [weakSelf.manager FetchAllPhotoForPHFetchResult:model.result Index:model.index FetchResult:^(NSArray *photos, NSArray *videos, NSArray *Objs) {
//                weakSelf.photos = [NSMutableArray arrayWithArray:photos];
//                weakSelf.videos = [NSMutableArray arrayWithArray:videos];
//                weakSelf.objs = [NSMutableArray arrayWithArray:Objs];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    weakSelf.albumView.list = albums;
//                    if (model.albumName.length == 0) {
//                        model.albumName = @"相机胶卷";
//                    }
//                    [weakSelf.titleBtn setTitle:model.albumName forState:UIControlStateNormal];
//                    weakSelf.title = model.albumName;
//                    CATransition *transition = [CATransition animation];
//                    transition.type = kCATransitionPush;
//                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//                    transition.fillMode = kCAFillModeForwards;
//                    transition.duration = 0.25;
//                    transition.subtype = kCATransitionFade;
//                    [[weakSelf.collectionView layer] addAnimation:transition forKey:@""];
//                    [weakSelf.collectionView reloadData];
//                });
//            }];
//        } IsShowSelectTag:isShow];
//    });
//}
//
//- (void)pushAlbumList:(UIButton *)button
//{
//    button.selected = !button.selected;
//    if (button.selected) {
//        if (self.isSelectedChange) {
//            self.isSelectedChange = NO;
//            if (self.currentSelectCount != self.albumModel.selectedCount) {
//                __weak typeof(self) weakSelf = self;
//                [self.manager FetchAllAlbum:^(NSArray *albums) {
//                    weakSelf.albumView.list = albums;
//                    weakSelf.albums = albums;
//                } IsShowSelectTag:YES];
//                self.currentSelectCount = self.albumModel.selectedCount;
//            }
//        }
//        self.albumsBgView.hidden = NO;
//        [UIView animateWithDuration:0.25 animations:^{
//            self.albumView.frame = CGRectMake(0, 64, self.view.frame.size.width, 340);
//            self.albumsBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//            button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//            
//        }];
//    }else {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.albumView.frame = CGRectMake(0, 64-340, self.view.frame.size.width, 340);
//            self.albumsBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
//            button.imageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
//        } completion:^(BOOL finished) {
//            self.albumsBgView.hidden = YES;
//        }];
//    }
//}
//
//- (void)setup
//{
//    if (self.manager.type == HXPhotoManagerSelectedTypePhoto) {
//        if (self.manager.networkPhotoUrls.count == 0) {
//            self.manager.maxNum = self.manager.photoMaxNum;
//        }
//        if (self.manager.endCameraVideos.count > 0) {
//            [self.manager.endCameraList removeObjectsInArray:self.manager.endCameraVideos];
//            [self.manager.endCameraVideos removeAllObjects];
//        }
//    }else if (self.manager.type == HXPhotoManagerSelectedTypeVideo) {
//        if (self.manager.networkPhotoUrls.count == 0) {
//            self.manager.maxNum = self.manager.videoMaxNum;
//        }
//        if (self.manager.endCameraPhotos.count > 0) {
//            [self.manager.endCameraList removeObjectsInArray:self.manager.endCameraPhotos];
//            [self.manager.endCameraPhotos removeAllObjects];
//        }
//    }else {
//        if (self.manager.networkPhotoUrls.count == 0) {
//            if (self.manager.videoMaxNum + self.manager.photoMaxNum != self.manager.maxNum) {
//                self.manager.maxNum = self.manager.videoMaxNum + self.manager.photoMaxNum;
//            }
//        }
//    }
//    self.manager.selectedList = [NSMutableArray arrayWithArray:self.manager.endSelectedList];
//    self.manager.selectedPhotos = [NSMutableArray arrayWithArray:self.manager.endSelectedPhotos];
//    self.manager.selectedVideos = [NSMutableArray arrayWithArray:self.manager.endSelectedVideos];
//    self.manager.cameraList = [NSMutableArray arrayWithArray:self.manager.endCameraList];
//    self.manager.cameraPhotos = [NSMutableArray arrayWithArray:self.manager.endCameraPhotos];
//    self.manager.cameraVideos = [NSMutableArray arrayWithArray:self.manager.endCameraVideos];
//    self.manager.selectedCameraList = [NSMutableArray arrayWithArray:self.manager.endSelectedCameraList];
//    self.manager.selectedCameraPhotos = [NSMutableArray arrayWithArray:self.manager.endSelectedCameraPhotos];
//    self.manager.selectedCameraVideos = [NSMutableArray arrayWithArray:self.manager.endSelectedCameraVideos];
//    self.manager.isOriginal = self.manager.endIsOriginal;
//    self.manager.photosTotalBtyes = self.manager.endPhotosTotalBtyes;
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    
//    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBarBtn setImage:[UIImage imageNamed:@"shuoshuodingwei_close"] forState:UIControlStateNormal];
//    leftBarBtn.frame = CGRectMake(0, 0, 30, 30);
//    [leftBarBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
//    if (self.manager.selectedList.count > 0) {
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//        [self.rightBtn setTitle:[NSString stringWithFormat:@"继续(%ld)",self.manager.selectedList.count] forState:UIControlStateNormal];
//        [self.rightBtn setTitleColor:[UIColor colorWithHexString:@"7269ff"] forState:UIControlStateNormal];
//        CGFloat rightBtnH = self.rightBtn.frame.size.height;
//        CGFloat rightBtnW = [HXPhotoTools getTextWidth:self.rightBtn.currentTitle withHeight:rightBtnH fontSize:14];
//        self.rightBtn.frame = CGRectMake(0, 0, rightBtnW + 20, rightBtnH);
//    }else {
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//        [self.rightBtn setTitle:@"继续" forState:UIControlStateNormal];
//        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.rightBtn.frame = CGRectMake(0, 0, 60, 25);
//    }
//    
//    HXAlbumTitleButton *titleBtn = [HXAlbumTitleButton buttonWithType:UIButtonTypeCustom];
//    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [titleBtn setImage:[HXPhotoTools hx_imageNamed:@"xiangjijiaojuanye_zhankai"] forState:UIControlStateNormal];
//    titleBtn.frame = CGRectMake(0, 0, 150, 30);
//    [titleBtn setTitle:@"相机胶卷" forState:UIControlStateNormal];
//    [titleBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
//    titleBtn.titleLabel.font = DDPingFangSCMediumFONT(17);
//    [titleBtn addTarget:self action:@selector(pushAlbumList:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView = titleBtn;
//    self.title = @"相机胶卷";
//    self.titleBtn = titleBtn;
//    
//    CGFloat width = self.view.frame.size.width;
//    CGFloat heght = self.view.frame.size.height;
//    CGFloat spacing = 3;
//    CGFloat CVwidth = (width - spacing * (self.manager.rowCount - 1) - 20) / self.manager.rowCount;
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(CVwidth, CVwidth);
//    flowLayout.minimumInteritemSpacing = spacing;
//    flowLayout.minimumLineSpacing = spacing;
//    
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, width - 20, heght) collectionViewLayout:flowLayout];
//    self.collectionView.contentInset = UIEdgeInsetsMake(spacing + 64, 0, 50 + spacing, 0);
//    self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
//    self.collectionView.dataSource = self;
//    self.collectionView.delegate = self;
//    self.collectionView.alwaysBounceVertical = YES;
//    self.collectionView.backgroundColor = [UIColor whiteColor];
//    [self.collectionView registerClass:[HXPhotoViewCell class] forCellWithReuseIdentifier:PhotoViewCellId];
//    [self.view addSubview:self.collectionView];
//    
//    HXPhotoBottomView *bottomView = [[HXPhotoBottomView alloc] initWithFrame:CGRectMake(0, heght - 44, width, 44)];
//    bottomView.delegate = self;
//    
//    [self.view addSubview:bottomView];
//    self.bottomView = bottomView;
//    self.bottomView.albumBtn.selected = YES;
//    _originalFrame = bottomView.originalBtn.frame;
//    
//    [self.view addSubview:self.albumsBgView];
//    HXAlbumListView *albumView = [[HXAlbumListView alloc] initWithFrame:CGRectMake(0, 64 - 340, width, 340)];
//    albumView.delegate = self;
//    [self.view addSubview:albumView];
//    self.albumView = albumView;
//}
//#pragma mark - 点击取消按钮 清空所有操作
//- (void)cancelClick
//{
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//    [self.manager.selectedList removeAllObjects];
//    [self.manager.selectedPhotos removeAllObjects];
//    [self.manager.selectedVideos removeAllObjects];
//    self.manager.isOriginal = NO;
//    self.manager.photosTotalBtyes = nil;
//    [self.manager.selectedCameraList removeAllObjects];
//    [self.manager.selectedCameraVideos removeAllObjects];
//    [self.manager.selectedCameraPhotos removeAllObjects];
//    [self.manager.cameraPhotos removeAllObjects];
//    [self.manager.cameraList removeAllObjects];
//    [self.manager.cameraVideos removeAllObjects];
//    if ([self.delegate respondsToSelector:@selector(photoViewControllerDidCancel)]) {
//        [self.delegate photoViewControllerDidCancel];
//    }
//    [self.navigationController popViewControllerAnimated:NO];
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.objs.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    HXPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoViewCellId forIndexPath:indexPath];
//    HXPhotoModel *model = self.objs[indexPath.item];
//    cell.delegate = self;
//    cell.model = model;
//    cell.index = indexPath;
//    if (!cell.firstRegisterPreview) {
//        if (model.type != HXPhotoModelMediaTypeCamera) {
//            if ([self respondsToSelector:@selector(traitCollection)]) {
//                if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
//                    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//                        [self registerForPreviewingWithDelegate:self sourceView:cell];
//                        cell.firstRegisterPreview = YES;
//                    }
//                }
//            }
//        }
//    }
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    HXPhotoViewCell *cell = (HXPhotoViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    [self cellDidSelectedBtnClick:cell Model:cell.model];
//}
//
//- (void)fullScreenCameraDidNextClick:(HXPhotoModel *)model {
//    [self cameraDidNextClick:model];
//}
//- (void)cameraDidNextClick:(HXPhotoModel *)model
//{
//    if (model.type == HXPhotoModelMediaTypeCameraVideo) {
//        [self.manager.selectedList removeAllObjects];
//        [self.manager.selectedPhotos removeAllObjects];
//        [self.manager.selectedVideos removeAllObjects];
//        self.manager.isOriginal = NO;
//        self.manager.photosTotalBtyes = nil;
//        [self.manager.selectedCameraList removeAllObjects];
//        [self.manager.selectedCameraVideos removeAllObjects];
//        [self.manager.selectedCameraPhotos removeAllObjects];
//        [self.manager.cameraPhotos removeAllObjects];
//        [self.manager.cameraList removeAllObjects];
//        [self.manager.cameraVideos removeAllObjects];
//        __weak typeof(self) weakSelf = self;
//        [self.manager FetchAllPhotoForPHFetchResult:self.albumModel.result Index:self.albumModel.index FetchResult:^(NSArray *photos, NSArray *videos, NSArray *Objs) {
//            weakSelf.photos = [NSMutableArray arrayWithArray:photos];
//            weakSelf.videos = [NSMutableArray arrayWithArray:videos];
//            weakSelf.objs = [NSMutableArray arrayWithArray:Objs];
//            CATransition *transition = [CATransition animation];
//            transition.type = kCATransitionPush;
//            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//            transition.fillMode = kCAFillModeForwards;
//            transition.duration = 0.25;
//            transition.subtype = kCATransitionFade;
//            [[weakSelf.collectionView layer] addAnimation:transition forKey:@""];
//            [weakSelf.collectionView reloadData];
//        }];
//        [self changeOriginalState:NO IsChange:NO];
//        self.manager.isOriginal = NO;
//        self.bottomView.originalBtn.selected = NO;
//        self.bottomView.previewBtn.enabled = NO;
//        self.bottomView.originalBtn.enabled = NO;
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//        [self.rightBtn setTitle:@"继续" forState:UIControlStateNormal];
//        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.rightBtn.frame = CGRectMake(0, 0, 60, 25);
//        self.isSelectedChange = NO;
//        return;
//    }
//    [self didTableViewCellClick:self.albums.firstObject animate:NO];
//    if (model.type == HXPhotoModelMediaTypeCameraPhoto) {
//        [self.photos insertObject:model atIndex:0];
//        if (self.manager.selectedPhotos.count <= self.manager.photoMaxNum) {
//            if (!self.manager.selectTogether) {
//                if (self.manager.selectedList.count > 0) {
//                    HXPhotoModel *phMd = self.manager.selectedList.firstObject;
//                    if ((phMd.type == HXPhotoModelMediaTypePhoto || phMd.type == HXPhotoModelMediaTypeLivePhoto) || (phMd.type == HXPhotoModelMediaTypePhotoGif || phMd.type == HXPhotoModelMediaTypeCameraPhoto)) {
//                        self.isSelectedChange = YES;
//                        self.albumModel.selectedCount++;
//                    }
//                }else {
//                    self.isSelectedChange = YES;
//                    self.albumModel.selectedCount++;
//                }
//            }else {
//                self.isSelectedChange = YES;
//                self.albumModel.selectedCount++;
//            }
//        }
//    }else if (model.type == HXPhotoModelMediaTypeCameraVideo) {
//        [self.manager.cameraVideos addObject:model];
//        [self.videos insertObject:model atIndex:0];
//        if (self.manager.selectedVideos.count != self.manager.videoMaxNum) {
//            if (!self.manager.selectTogether) {
//                if (self.manager.selectedList.count > 0) {
//                    HXPhotoModel *phMd = self.manager.selectedList.firstObject;
//                    if (phMd.type == HXPhotoModelMediaTypeVideo || phMd.type == HXPhotoModelMediaTypeCameraVideo) {
//                        [self.manager.selectedCameraVideos insertObject:model atIndex:0];
//                        [self.manager.selectedVideos addObject:model];
//                        [self.manager.selectedList addObject:model];
//                        [self.manager.selectedCameraList addObject:model];
//                        self.isSelectedChange = YES;
//                        model.selected = YES;
//                        self.albumModel.selectedCount++;
//                    }
//                }else {
//                    
//                    [self.manager.selectedCameraVideos insertObject:model atIndex:0];
//                    [self.manager.selectedVideos addObject:model];
//                    [self.manager.selectedList addObject:model];
//                    [self.manager.selectedCameraList addObject:model];
//                    self.isSelectedChange = YES;
//                    model.selected = YES;
//                    self.albumModel.selectedCount++;
//                }
//            }else {
//                [self.manager.selectedCameraVideos insertObject:model atIndex:0];
//                [self.manager.selectedVideos addObject:model];
//                [self.manager.selectedList addObject:model];
//                [self.manager.selectedCameraList addObject:model];
//                self.isSelectedChange = YES;
//                model.selected = YES;
//                self.albumModel.selectedCount++;
//            }
//        }
//    }
//    NSInteger cameraIndex = self.manager.openCamera ? 1 : 0;
//    [self.collectionView reloadData];
//    [self changeButtonClick:model];
//}
//- (void)didTableViewCellClick:(HXAlbumModel *)model animate:(BOOL)anim
//{
//    self.currentSelectCount = model.selectedCount;
//    self.albumModel = model;
//    if (anim) {
//        [self pushAlbumList:self.titleBtn];
//    }
//    self.title = model.albumName;
//    [self.titleBtn setTitle:model.albumName forState:UIControlStateNormal];
//    __weak typeof(self) weakSelf = self;
//    [self.manager FetchAllPhotoForPHFetchResult:model.result Index:model.index FetchResult:^(NSArray *photos, NSArray *videos, NSArray *Objs) {
//        weakSelf.photos = [NSMutableArray arrayWithArray:photos];
//        weakSelf.videos = [NSMutableArray arrayWithArray:videos];
//        weakSelf.objs = [NSMutableArray arrayWithArray:Objs];
//        CATransition *transition = [CATransition animation];
//        transition.type = kCATransitionPush;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.fillMode = kCAFillModeForwards;
//        transition.duration = 0.25;
//        transition.subtype = kCATransitionFade;
//        [[weakSelf.collectionView layer] addAnimation:transition forKey:@""];
//        [weakSelf.collectionView reloadData];
//        [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//    }];
//}
//- (void)didSelectedClick:(HXPhotoModel *)model AddOrDelete:(BOOL)state
//{
//    if (state) {
//        self.albumModel.selectedCount++;
//    }else {
//        self.albumModel.selectedCount--;
//    }
//    NSInteger index = 0;
//    if (self.albumModel.index == 0) {
//        if (self.manager.cameraList.count > 0) {
//            if (model.type != HXPhotoModelMediaTypeCameraPhoto && model.type != HXPhotoModelMediaTypeCameraVideo) {
//                index = model.albumListIndex + self.manager.cameraList.count;
//            }else {
//                index = model.albumListIndex;
//            }
//        }else {
//            index = model.albumListIndex;
//        }
//    }else {
//        index = model.albumListIndex;
//    }
//    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
//    [self changeButtonClick:model];
//}
//
//#pragma mark - cell选中代理
//- (void)cellDidSelectedBtnClick:(HXPhotoViewCell *)cell Model:(HXPhotoModel *)model
//{
//    if (!cell.selectBtn.selected) {
//        if (self.manager.selectedList.count == self.manager.maxNum) {
//            [self.view showImageHUDText:[NSString stringWithFormat:@"最多只能选择%ld个",self.manager.maxNum]];
//            return;
//        }
//        if (self.manager.type == HXPhotoManagerSelectedTypePhotoAndVideo) {
//            if ((model.type == HXPhotoModelMediaTypePhoto || model.type == HXPhotoModelMediaTypePhotoGif) || (model.type == HXPhotoModelMediaTypeCameraPhoto || model.type == HXPhotoModelMediaTypeLivePhoto)) {
//                if (self.manager.videoMaxNum > 0) {
//                    if (!self.manager.selectTogether) {
//                        if (self.manager.selectedVideos.count > 0 ) {
//                            [self.view showImageHUDText:@"图片不能和视频同时选择"];
//                            return;
//                        }
//                    }
//                }
//                if (self.manager.selectedPhotos.count == self.manager.photoMaxNum) {
//                    [self.view showImageHUDText:[NSString stringWithFormat:@"最多只能选择%ld张图片",self.manager.photoMaxNum]];
//                    return;
//                }
//            }else if (model.type == HXPhotoModelMediaTypeVideo || model.type == HXPhotoModelMediaTypeCameraVideo) {
//                if (self.manager.photoMaxNum > 0) {
//                    if (!self.manager.selectTogether) {
//                        if (self.manager.selectedPhotos.count > 0 ) {
//                            [self.view showImageHUDText:@"视频不能和图片同时选择"];
//                            return;
//                        }
//                    }
//                }
//                if (self.manager.selectedVideos.count == self.manager.videoMaxNum) {
//                    [self.view showImageHUDText:[NSString stringWithFormat:@"最多只能选择%ld个视频",self.manager.videoMaxNum]];
//                    return;
//                }
//            }
//        }else if (self.manager.type == HXPhotoManagerSelectedTypePhoto) {
//            if (self.manager.selectedPhotos.count == self.manager.photoMaxNum) {
//                [self.view showImageHUDText:[NSString stringWithFormat:@"最多只能选择%ld张图片",self.manager.photoMaxNum]];
//                return;
//            }
//        }else if (self.manager.type == HXPhotoManagerSelectedTypeVideo) {
//            if (self.manager.selectedVideos.count == self.manager.videoMaxNum) {
//                [self.view showImageHUDText:[NSString stringWithFormat:@"最多只能选择%ld个视频",self.manager.videoMaxNum]];
//                return;
//            }
//        }
//        if (model.type == HXPhotoModelMediaTypeVideo) {
//            if (model.asset.duration < 3) {
//                [self.view showImageHUDText:@"视频少于3秒,暂不支持"];
//                return;
//            }
//        }
//        cell.maskView.hidden = NO;
//        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//        anim.duration = 0.25;
//        anim.values = @[@(1.2),@(0.8),@(1.1),@(0.9),@(1.0)];
//        [cell.selectBtn.layer addAnimation:anim forKey:@""];
//    }else {
//        cell.maskView.hidden = YES;
//    }
//    cell.selectBtn.selected = !cell.selectBtn.selected;
//    cell.model.selected = cell.selectBtn.selected;
//    BOOL selected = cell.selectBtn.selected;
//    
//    if (selected) {
//        if (model.type == HXPhotoModelMediaTypeLivePhoto) {
//            [cell startLivePhoto];
//        }
//        if (model.type == HXPhotoModelMediaTypePhoto || (model.type == HXPhotoModelMediaTypePhotoGif || model.type == HXPhotoModelMediaTypeLivePhoto)) {
//            [self.manager.selectedPhotos addObject:model];
//        }else if (model.type == HXPhotoModelMediaTypeVideo) {
//            [self.manager.selectedVideos addObject:model];
//        }else if (model.type == HXPhotoModelMediaTypeCameraPhoto) {
//            [self.manager.selectedPhotos addObject:model];
//            [self.manager.selectedCameraPhotos addObject:model];
//            [self.manager.selectedCameraList addObject:model];
//        }else if (model.type == HXPhotoModelMediaTypeCameraVideo) {
//            [self.manager.selectedVideos addObject:model];
//            [self.manager.selectedCameraVideos addObject:model];
//            [self.manager.selectedCameraList addObject:model];
//        }
//        self.albumModel.selectedCount++;
//        model.selectedIndex = self.manager.selectedList.count + 1;
//        [self.manager.selectedList addObject:model];
//    }else {
//        if (model.type == HXPhotoModelMediaTypeLivePhoto) {
//            [cell stopLivePhoto];
//        }
//        int i = 0;
//        for (HXPhotoModel *subModel in self.manager.selectedList) {
//            if ((model.type == HXPhotoModelMediaTypePhoto || model.type == HXPhotoModelMediaTypePhotoGif) || (model.type == HXPhotoModelMediaTypeVideo || model.type == HXPhotoModelMediaTypeLivePhoto)) {
//                if ([subModel.asset.localIdentifier isEqualToString:model.asset.localIdentifier]) {
//                    if (model.type == HXPhotoModelMediaTypePhoto || model.type == HXPhotoModelMediaTypePhotoGif || model.type == HXPhotoModelMediaTypeLivePhoto) {
//                        [self.manager.selectedPhotos removeObject:subModel];
//                    }else if (model.type == HXPhotoModelMediaTypeVideo) {
//                        [self.manager.selectedVideos removeObject:subModel];
//                    }
//                    self.albumModel.selectedCount--;
//                    HXPhotoModel *subModel = self.objs[cell.index.item];
//                    subModel.selectedIndex = 0;
//                    
//                    [self.manager.selectedList removeObjectAtIndex:i];
//                    break;
//                }
//            }else if (model.type == HXPhotoModelMediaTypeCameraPhoto || model.type == HXPhotoModelMediaTypeCameraVideo){
//                if ([subModel.cameraIdentifier isEqualToString:model.cameraIdentifier]) {
//                    if (model.type == HXPhotoModelMediaTypeCameraPhoto) {
//                        [self.manager.selectedPhotos removeObject:subModel];
//                        [self.manager.selectedCameraPhotos removeObject:subModel];
//                    }else if (model.type == HXPhotoModelMediaTypeCameraVideo) {
//                        [self.manager.selectedVideos removeObject:subModel];
//                        [self.manager.selectedCameraVideos removeObject:subModel];
//                    }
//                    self.albumModel.selectedCount--;
//                    [self.manager.selectedList removeObjectAtIndex:i];
//                    HXPhotoModel *subModel = self.objs[cell.index.item];
//                    subModel.selectedIndex = 0;
//                    [self.manager.selectedCameraList removeObject:subModel];
//                    break;
//                }
//            }
//            i++;
//        }
//        int deleteIndex = i--;
//        for (int num = 0; num < self.manager.selectedList.count; num++) {
//            HXPhotoModel *subModel = self.manager.selectedList[num];
//            NSLog(@"===%d===",subModel.selectedIndex);
//            if (num >= deleteIndex) {
//                subModel.selectedIndex = num + 1;
//            }
//        }
//    }
//    [self changeButtonClick:model];
//    __weak typeof(self) weakSelf = self;
//    [self.manager FetchAllPhotoForPHFetchResult:self.albumModel.result Index:self.albumModel.index FetchResult:^(NSArray *photos, NSArray *videos, NSArray *Objs) {
//        weakSelf.photos = [NSMutableArray arrayWithArray:photos];
//        weakSelf.videos = [NSMutableArray arrayWithArray:videos];
//        weakSelf.objs = [NSMutableArray arrayWithArray:Objs];
//        CATransition *transition = [CATransition animation];
//        transition.type = kCATransitionPush;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.fillMode = kCAFillModeForwards;
//        transition.duration = 0.25;
//        transition.subtype = kCATransitionFade;
//        [[weakSelf.collectionView layer] addAnimation:transition forKey:@""];
//        [weakSelf.collectionView reloadData];
//    }];
//}
//- (void)cellChangeLivePhotoState:(HXPhotoModel *)model
//{
//    for (HXPhotoModel *PHModel in self.manager.selectedList) {
//        if ([model.asset.localIdentifier isEqualToString:PHModel.asset.localIdentifier]) {
//            PHModel.isCloseLivePhoto = model.isCloseLivePhoto;
//            break;
//        }
//    }
//    for (HXPhotoModel *PHModel in self.manager.selectedPhotos) {
//        if ([model.asset.localIdentifier isEqualToString:PHModel.asset.localIdentifier]) {
//            PHModel.isCloseLivePhoto = model.isCloseLivePhoto;
//            break;
//        }
//    }
//}
//- (void)changeButtonClick:(HXPhotoModel *)model
//{
//    self.isSelectedChange = YES;
//    if (self.manager.selectedList.count > 0) {
//        if (self.manager.type != HXPhotoManagerSelectedTypeVideo) {
//            if (self.manager.type == HXPhotoManagerSelectedTypePhotoAndVideo) {
//                BOOL isVideo = NO, isPhoto = NO;
//                for (HXPhotoModel *model in self.manager.selectedList) {
//                    if (model.type == HXPhotoModelMediaTypePhoto || (model.type == HXPhotoModelMediaTypePhotoGif || model.type == HXPhotoModelMediaTypeLivePhoto)) {
//                        isPhoto = YES;
//                    }else if (model.type == HXPhotoModelMediaTypeVideo) {
//                        isVideo = YES;
//                    }else if (model.type == HXPhotoModelMediaTypeCameraPhoto) {
//                        isPhoto = YES;
//                    }else if (model.type == HXPhotoModelMediaTypeCameraVideo) {
//                        isVideo = YES;
//                    }
//                }
//                if (self.manager.isOriginal) {
//                    [self changeOriginalState:YES IsChange:YES];
//                }
//                if ((isPhoto && isVideo) || isPhoto) {
//                    self.bottomView.originalBtn.enabled = YES;
//                }else {
//                    [self changeOriginalState:NO IsChange:NO];
//                    self.bottomView.originalBtn.enabled = NO;
//                    self.bottomView.originalBtn.selected = NO;
//                    self.manager.isOriginal = NO;
//                }
//            }else {
//                self.bottomView.originalBtn.enabled = YES;
//            }
//        }
//        self.bottomView.previewBtn.enabled = YES;
//        
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//        [self.rightBtn setTitle:[NSString stringWithFormat:@"继续(%ld)",self.manager.selectedList.count] forState:UIControlStateNormal];
//        [self.rightBtn setTitleColor:[UIColor colorWithHexString:@"7269ff"] forState:UIControlStateNormal];
//        
//        CGFloat rightBtnH = self.rightBtn.frame.size.height;
//        CGFloat rightBtnW = [HXPhotoTools getTextWidth:self.rightBtn.currentTitle withHeight:rightBtnH fontSize:14];
//        self.rightBtn.frame = CGRectMake(0, 0, rightBtnW + 20, rightBtnH);
//    }else {
//        [self changeOriginalState:NO IsChange:NO];
//        self.manager.isOriginal = NO;
//        self.bottomView.originalBtn.selected = NO;
//        self.bottomView.previewBtn.enabled = NO;
//        self.bottomView.originalBtn.enabled = NO;
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//        [self.rightBtn setTitle:@"继续" forState:UIControlStateNormal];
//        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.rightBtn.frame = CGRectMake(0, 0, 60, 25);
//    }
//}
//
//#pragma mark - 拍照
//- (void)didPhotoBottomViewClick:(HXPhotoBottomType)type Button:(UIButton *)button
//{
//    if (type == HXPhotoBottomTyOriginalAlbum) {
//        self.bottomView.albumBtn.selected = YES;
//        self.bottomView.photographBtn.selected = NO;
//    }
//    if (type == HXPhotoBottomTyOriginalPhotograph) {
//        self.bottomView.albumBtn.selected = NO;
//        self.bottomView.photographBtn.selected = YES;
//        
//        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            [self.view showImageHUDText:@"此设备不支持相机!"];
//            return;
//        }
//        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
//            [alert show];
//            return;
//        }
//        HXCameraType type = 0;
//        if (self.manager.type == HXPhotoManagerSelectedTypePhotoAndVideo) {
//            if (self.manager.selectedList.count >= self.manager.maxNum) {
//                [self.view showImageHUDText:@"已达最大数!"];
//                return;
//            }else {
//                type = HXCameraTypePhotoAndVideo;
//            }
//        }else if (self.manager.type == HXPhotoManagerSelectedTypePhoto) {
//            if (self.manager.selectedList.count >= self.manager.photoMaxNum) {
//                [self.view showImageHUDText:@"照片已达最大数"];
//                return;
//            }
//            type = HXCameraTypePhoto;
//        }else if (self.manager.type == HXPhotoManagerSelectedTypeVideo) {
//            if (self.manager.selectedList.count >= self.manager.videoMaxNum) {
//                [self.view showImageHUDText:@"视频已达最大数!"];
//                return;
//            }
//            type = HXCameraTypeVideo;
//        }
//        HXFullScreenCameraViewController *vc1 = [[HXFullScreenCameraViewController alloc] init];
//        vc1.type = HXCameraTypePhotoAndVideo;
//        vc1.delegate = self;
//        [self.navigationController pushViewController:vc1 animated:NO];
//    }
//}
//
//- (void)previewVideoDidNextClick
//{
//    [self didNextClick:self.rightBtn];
//}
//
//- (void)previewVideoDidSelectedClick:(HXPhotoModel *)model
//{
//    [self.collectionView reloadData];
//    [self changeButtonClick:model];
//}
//- (void)changeOriginalState:(BOOL)selected IsChange:(BOOL)isChange
//{
//    if (selected) {
//        if (isChange) {
//            self.bottomView.originalBtn.frame = _originalFrame;
//            [self.bottomView.originalBtn setTitle:@"原图" forState:UIControlStateNormal];
//        }
//        _originalFrame = self.bottomView.originalBtn.frame;
//        [self.indica startAnimating];
//        self.indica.hidden = NO;
//        CGFloat indicaW = self.indica.frame.size.width;
//        CGFloat originalBtnX = self.bottomView.originalBtn.frame.origin.x;
//        CGFloat originalBtnY = self.bottomView.originalBtn.frame.origin.y;
//        CGFloat originalBtnW = self.bottomView.originalBtn.frame.size.width;
//        CGFloat originalBtnH = self.bottomView.originalBtn.frame.size.height;
//        self.bottomView.originalBtn.frame = CGRectMake(originalBtnX, originalBtnY, originalBtnW + indicaW + 5, originalBtnH);
//        __weak typeof(self) weakSelf = self;
//        [HXPhotoTools FetchPhotosBytes:self.manager.selectedPhotos completion:^(NSString *totalBytes) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (!weakSelf.manager.isOriginal) {
//                    return;
//                }
//                weakSelf.manager.photosTotalBtyes = totalBytes;
//                CGFloat totalW = [HXPhotoTools getTextWidth:[NSString stringWithFormat:@"(%@)",totalBytes] withHeight:originalBtnH fontSize:14];
//                [weakSelf.bottomView.originalBtn setTitle:[NSString stringWithFormat:@"原图(%@)",totalBytes] forState:UIControlStateNormal];
//                [weakSelf.indica stopAnimating];
//                weakSelf.indica.hidden = YES;
//                weakSelf.bottomView.originalBtn.frame = CGRectMake(originalBtnX, originalBtnY, originalBtnW+totalW, originalBtnH);
//            });
//        }];
//    }else {
//        [self.indica stopAnimating];
//        self.indica.hidden = YES;
//        self.manager.photosTotalBtyes = nil;
//        [self.bottomView.originalBtn setTitle:@"原图" forState:UIControlStateNormal];
//        self.bottomView.originalBtn.frame = _originalFrame;
//    }
//}
//
//- (void)previewDidNextClick
//{
//    [self didNextClick:self.rightBtn];
//}
//
//#pragma mark - 点击下一步执行的方法
//- (void)didNextClick:(UIButton *)button
//{
//    if (self.manager.selectedCameraList.count == 0) {
//        [self.manager.cameraList removeAllObjects];
//        [self.manager.cameraVideos removeAllObjects];
//        [self.manager.cameraPhotos removeAllObjects];
//    }
//    WWAlbumPreviewViewController *previewVC = [[WWAlbumPreviewViewController alloc] init];
//    [self.navigationController pushViewController:previewVC animated:NO];
//}
//
//- (UIActivityIndicatorView *)indica
//{
//    if (!_indica) {
//        _indica = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        CGFloat indicaX = self.bottomView.originalBtn.titleLabel.frame.origin.x + [HXPhotoTools getTextWidth:@"原图" withHeight:self.bottomView.originalBtn.frame.size.height / 2 fontSize:14] + 5;
//        CGFloat indicaW = _indica.frame.size.width;
//        CGFloat indicaH = _indica.frame.size.height;
//        _indica.frame = CGRectMake(indicaX, 0, indicaW, indicaH);
//        _indica.center = CGPointMake(_indica.center.x, self.bottomView.originalBtn.frame.size.height / 2);
//        [self.bottomView.originalBtn addSubview:_indica];
//    }
//    return _indica;
//}
//
//- (UIButton *)rightBtn
//{
//    if (!_rightBtn) {
//        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_rightBtn setTitle:@"继续" forState:UIControlStateNormal];
//        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
//        [_rightBtn setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
//        [_rightBtn addTarget:self action:@selector(didNextClick:) forControlEvents:UIControlEventTouchUpInside];
//        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        _rightBtn.frame = CGRectMake(0, 0, 60, 25);
//    }
//    return _rightBtn;
//}
//
//- (UIView *)albumsBgView
//{
//    if (!_albumsBgView) {
//        _albumsBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
//        _albumsBgView.hidden = YES;
//        _albumsBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
//        [_albumsBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didAlbumsBgViewClick)]];
//    }
//    return _albumsBgView;
//}
//
//- (void)didAlbumsBgViewClick
//{
//    [self pushAlbumList:self.titleBtn];
//}
//
//- (void)setNavBarAppearance:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    UINavigationBar *navBar = self.navigationController.navigationBar;
//    navBar.tintColor = [UIColor whiteColor];
//    navBar.barTintColor = nil;
//    navBar.shadowImage = nil;
//    navBar.translucent = YES;
//    navBar.barStyle = UIBarStyleDefault;
//    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
//}
//
//- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
//    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
//        return (UIImageView *)view;
//    }
//    for (UIView *subview in view.subviews) {
//        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
//        if (imageView) {
//            return imageView;
//        }
//    }
//    return nil;
//}
//
//@end
//
//@interface HXPhotoBottomView ()
//@end
//@implementation HXPhotoBottomView
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
//        [self setup];
//    }
//    return self;
//}
//
//- (void)setup{
//    UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [albumBtn setTitle:@"图库" forState:UIControlStateNormal];
//    [albumBtn setTitleColor:[UIColor colorWithHexString:@"7269ff"] forState:UIControlStateNormal];
//    albumBtn.titleLabel.font = DDPingFangSCMediumFONT(14);
//    [albumBtn addTarget:self action:@selector(didAlbumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:albumBtn];
//    
//    albumBtn.frame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);
//    albumBtn.center = CGPointMake(self.frame.size.width / 4, self.frame.size.height / 2);
//    self.albumBtn = albumBtn;
//    
//    UIButton *photographBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [photographBtn setTitle:@"拍照" forState:UIControlStateNormal];
//    [photographBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
//    
//    photographBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8 + 8, 0, 0);
//    photographBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
//    photographBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [photographBtn addTarget:self action:@selector(didPhotographBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:photographBtn];
//    
//    photographBtn.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
//    photographBtn.center = CGPointMake(self.frame.size.width / 4 * 3, self.frame.size.height / 2);
//    self.photographBtn = photographBtn;
//    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
//    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
//    [self addSubview:lineView];
//}
//-(void)didAlbumBtnClick:(UIButton *)sender{
//    if ([self.delegate respondsToSelector:@selector(didPhotoBottomViewClick:Button:)]) {
//        [self.delegate didPhotoBottomViewClick:HXPhotoBottomTyOriginalAlbum Button:sender];
//    }
//}
//-(void)didPhotographBtnClick:(UIButton *)sender{
//    if ([self.delegate respondsToSelector:@selector(didPhotoBottomViewClick:Button:)]) {
//        [self.delegate didPhotoBottomViewClick:HXPhotoBottomTyOriginalPhotograph Button:sender];
//    }
//}
//@end
//
//#import "WWAudioRecorderViewController.h"
//@interface WWAudioRecorderViewController (){
//    WWAudioRecorder *audioRecorder;
//    WWAudioPlayer *audioPlayer;
//    UILabel *label;
//    CGFloat count;
//    UIImageView *_imageBg;
//    UIImageView *_imageShuXian;
//    UIScrollView  *_ScrollView;
//    AHSegmentedSlider *slider;
//    CGFloat sliderCurrentValue;
//}
//
//@property (nonatomic, strong) NSTimer *timer;
//@property (assign, nonatomic) NSInteger videoTime;
//@property (nonatomic, strong) UILabel *recordingHintLabel;
//@property (nonatomic, strong) UILabel *pressRecordBtn;
//@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
//@property (nonatomic, strong) UIButton *reRecordBtn;
//@property (nonatomic, strong) UIButton *playBtn;
//@property (nonatomic, strong) YFGIFImageView *siriView;
//@property (nonatomic, assign) CGRect shuxianFrame;
//@end
//
//@implementation WWAudioRecorderViewController
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    count = -3;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"e5e5e5"],NSFontAttributeName:DDPingFangSCMediumFONT(17)}];
//    audioRecorder = [[WWAudioRecorder alloc] init];
//    audioRecorder.isNeedConvert=YES;
//    audioPlayer = [[WWAudioPlayer alloc] init];
//    audioPlayer.isNeedConvert=YES;
//    [self configView];
//    [self layoutBtns];
//}
//
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [self.siriView stopAnimating];
//    self.siriView = nil;
//    [self.timer invalidate];
//    self.timer = nil;
//}
//-(void)configView{
//    NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"siri.gif" ofType:nil]];
//    self.siriView = [[YFGIFImageView alloc] initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 180)];
//    self.siriView.backgroundColor = [UIColor colorWithRed:14/255.0 green:15/255.0 blue:26/255.0 alpha:1];
//    self.siriView.gifData = gifData;
//    [self.view addSubview:self.siriView];
//    [self.siriView startGIF];
//    _imageBg= [[UIImageView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - kRecordBackgroundHeight - 85, SCREEN_WIDTH - 40, kRecordBackgroundHeight)];
//    _imageBg.backgroundColor = [UIColor blackColor];
//    _imageBg.userInteractionEnabled = YES;
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kRecordBackgroundHeight - 1, SCREEN_WIDTH - 40, 0.5)];
//    line.backgroundColor = kLineColor;
//    [_imageBg addSubview:line];
//    [self.view addSubview:_imageBg];
//    _imageShuXian= [[UIImageView alloc]initWithFrame:CGRectMake(1, 0 ,  kShuXianWidth, kRecordBackgroundHeight - 2 * kRecordTopHight)];
//    self.shuxianFrame = CGRectMake(1, 0 ,  kShuXianWidth, kRecordBackgroundHeight - 2 * kRecordTopHight);
//    _imageShuXian.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"75a5fa"]];
//    _imageShuXian.tag = 999;
//    [_imageBg addSubview:_imageShuXian];
//    _ScrollView = [[UIScrollView alloc]init];
//    _ScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 40, kRecordBackgroundHeight);
//    _ScrollView.backgroundColor = [UIColor clearColor];
//    _ScrollView.showsHorizontalScrollIndicator = YES;
//    _ScrollView.scrollEnabled = NO;
//    [_imageBg addSubview:_ScrollView];
//    [_imageBg bringSubviewToFront:_imageShuXian];
//    self.view.backgroundColor = [UIColor blackColor];
//    slider = [[SegmentedSlider alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - kRecordBackgroundHeight - 115, self.view.frame.size.width- 40, 30)];
//    [slider setDelegate:self];
//    [slider setMinValue:0];
//    [slider setMaxValue:10];
//    [slider setMarginInset:0.1];
//    [slider setNumberOfPoints:11];
//    [slider setBaseLineWidth:2];
//    [slider setBarLineWidth:2];
//    [slider setBarColor:[UIColor colorWithHexString:@"ff2366"]];
//    [slider setBaseColor:[UIColor lightGrayColor]];
//    [slider setVisibleNodes:YES];
//    [slider setBaseNodeColor:[UIColor lightGrayColor]];
//    [slider setBarNodeColor:[UIColor colorWithHexString:@"ff2366"]];
//    [slider setBaseNodeRadius:2];
//    [slider setBarNodeRadius:3];
//    [self.view addSubview:slider];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//    self.timer.fireDate = [NSDate distantFuture];
//}
//
//-(void)layoutBtns{
//    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//    attachment.image = [UIImage circleImageWithColor:[UIColor colorWithHexString:@"ff2366"] WithBounds:CGRectMake(0, 0, 48,48)];
//    attachment.bounds = CGRectMake(0, -1, 16, 16);
//    NSAttributedString *attachmentStr = [NSAttributedString attributedStringWithAttachment:attachment];
//    NSMutableAttributedString *attrituteTitle = [[NSMutableAttributedString alloc] initWithString:@""];
//    [attrituteTitle insertAttributedString:[[NSAttributedString alloc] initWithString:@"  录音中..."] atIndex:attrituteTitle.length];
//    [attrituteTitle setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"ffffff"], NSFontAttributeName : DDPingFangSCMediumFONT(18)} range:NSMakeRange(0, attrituteTitle.length)];
//    [attrituteTitle insertAttributedString:attachmentStr atIndex:0];
//    self.recordingHintLabel = [UILabel new];
//    [self.view addSubview:self.recordingHintLabel];
//    self.recordingHintLabel.hidden = YES;
//    self.recordingHintLabel.attributedText = attrituteTitle;
//    self.recordingHintLabel.textAlignment = NSTextAlignmentCenter;
//    self.recordingHintLabel.numberOfLines = 0;
//    self.recordingHintLabel.frame = CGRectMake(20, slider.frame.origin.y - 42, 150,20);
//    self.recordingHintLabel.center = CGPointMake(self.view.center.x, self.recordingHintLabel.center.y);
//    
//    self.pressRecordBtn = [UILabel new];
//    self.pressRecordBtn.text = @"按住录音";
//    self.pressRecordBtn.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.pressRecordBtn];
//    self.pressRecordBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 65, kRELATIVE_W(310), 42);
//    self.pressRecordBtn.center = CGPointMake(self.view.center.x, self.pressRecordBtn.center.y);
//    self.pressRecordBtn.layer.cornerRadius = 21;
//    self.pressRecordBtn.layer.masksToBounds = YES;
//    self.pressRecordBtn.backgroundColor = [UIColor colorWithHexString:@"75a5fa"];
//    
//    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(recordLongPressEvent:)];
//    self.longPressGestureRecognizer.minimumPressDuration = 0.7;
//    self.pressRecordBtn.userInteractionEnabled = YES;
//    [self.pressRecordBtn addGestureRecognizer:self.longPressGestureRecognizer];
//    
//    self.reRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:self.reRecordBtn];
//    [self.reRecordBtn addTarget:self action:@selector(reRecordBtAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.reRecordBtn setTitle:@"重录" forState:UIControlStateNormal];
//    self.reRecordBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - kRELATIVE_W(310) / 2, SCREEN_HEIGHT - 65, kRELATIVE_W(310) / 2 - 10, 42);
//    self.reRecordBtn.hidden = YES;
//    self.reRecordBtn.layer.cornerRadius = 21;
//    self.reRecordBtn.layer.masksToBounds = YES;
//    self.reRecordBtn.backgroundColor = [UIColor colorWithHexString:@"75a5fa"];
//    
//    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:self.playBtn];
//    [self.playBtn addTarget:self action:@selector(startPlayBtAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.playBtn setImage:[UIImage imageNamed:@"luyin_bofang"] forState:UIControlStateNormal];
//    [self.playBtn setImage:[UIImage imageNamed:@"luyin_zanting"] forState:UIControlStateSelected];
//    self.playBtn.frame = CGRectMake(SCREEN_WIDTH / 2 + 10, SCREEN_HEIGHT - 65, kRELATIVE_W(310) / 2 - 10, 42);
//    self.playBtn.hidden = YES;
//    self.playBtn.layer.cornerRadius = 21;
//    self.playBtn.layer.masksToBounds = YES;
//    self.playBtn.backgroundColor = [UIColor colorWithHexString:@"75a5fa"];
//}
//#pragma mark - 长按手势
//- (void)recordLongPressEvent:(UILongPressGestureRecognizer *)longPgr {
//    if (longPgr.state == UIGestureRecognizerStatePossible) {
//    }
//    if (longPgr.state == UIGestureRecognizerStateBegan) {
//        count = -3;
//        self.recordingHintLabel.hidden = NO;
//        self.pressRecordBtn.hidden = NO;
//        self.reRecordBtn.hidden = YES;
//        self.playBtn.hidden = YES;
//        [self startRecordBtAction];
//        self.timer.fireDate = [NSDate distantPast];
//    }
//    if (longPgr.state == UIGestureRecognizerStateChanged) {
//    }
//    if (longPgr.state == UIGestureRecognizerStateCancelled ||
//        longPgr.state == UIGestureRecognizerStateEnded){
//        [self endRecordBtAction];
//        if (self.videoTime < 3) {
//        }else {
//        }
//        self.recordingHintLabel.hidden = YES;
//        self.pressRecordBtn.hidden = YES;
//        self.reRecordBtn.hidden = NO;
//        self.playBtn.hidden = NO;
//    }
//}
//-(void)startRecordBtAction{
//    [audioRecorder startRecordWithFilePath:[WWAudioPath recordPathOrigin]
//                              updateMeters:^(float meters){
//                                  [self updateVolumeUI:meters];
//                              }
//                                   success:^(NSData *recordData){
//                                       NSLog(@"录音成功");
//                                       label.hidden=YES;
//                                   }
//                                    failed:^(NSError *error){
//                                        NSLog(@"录音失败");
//                                        label.hidden=YES;
//                                    }];
//}
//
//-(void)endRecordBtAction{
//    [audioRecorder stopRecord];
//    sliderCurrentValue = 0;
//    self.timer.fireDate = [NSDate distantFuture];
//}
//
//-(void)reRecordBtAction{
//    _imageShuXian.frame = self.shuxianFrame;
//    self.pressRecordBtn.hidden = NO;
//    self.recordingHintLabel.hidden = YES;
//    self.reRecordBtn.hidden = YES;
//    self.playBtn.hidden = YES;
//    slider.curretValue = 0;
//    sliderCurrentValue = 0;
//    self.timer.fireDate = [NSDate distantFuture];
//    self.playBtn.selected = NO;
//    [audioPlayer stopPlay];
//    self.pressRecordBtn.backgroundColor = [UIColor colorWithHexString:@"75a5fa"];
//    for ( UIView *subView in _ScrollView.subviews ) {
//        [subView removeFromSuperview];
//    }
//}
//
//-(void)startPlayBtAction:(UIButton *)sender{
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        sliderCurrentValue = 0;
//        self.timer.fireDate = [NSDate distantPast];
//        count = -3;
//        
//        for ( UIView *subView in _ScrollView.subviews ) {
//            [subView removeFromSuperview];
//        }
//        
//        _imageShuXian.frame = self.shuxianFrame;
//        NSData *data = [NSData dataWithContentsOfFile:[WWAudioPath recordPathOriginToAMR]];
//        NSLog(@"%lu",(unsigned long)data.length);
//        [audioPlayer startPlayAudioFile:[WWAudioPath recordPathOriginToAMR]
//                           updateMeters:^(float meters){
//                               [self updateVolumeUI:meters];
//                           }
//                                success:^{
//                                    NSLog(@"播放成功");
//                                    [self.playBtn setImage:[UIImage imageNamed:@"luyin_bofang"] forState:UIControlStateNormal];
//                                    sender.selected = !sender.selected;
//                                    self.timer.fireDate = [NSDate distantFuture];
//                                } failed:^(NSError *error) {
//                                    NSLog(@"播放失败");
//                                }];
//    }else{
//        [audioPlayer stopPlay];
//        self.timer.fireDate = [NSDate distantFuture];
//    }
//}
//#pragma mark - updateVolumeUI
//-(void)updateVolumeUI:(float )meters{
//    
//    if (meters!= 0) {
//        float m = fabsf(meters);
//        CGFloat iconNumber = 0;
//        float scale = (60 - m )/60;
//        if (scale <= 0.1f ){
//            iconNumber = 0.1f;
//        }
//        else if (scale > 0.1f && scale <= 0.15f) {
//            iconNumber = 0.2;
//        }
//        else if (scale > 0.15f && scale <= 0.2f) {
//            iconNumber = 0.3;
//        }
//        else if (scale > 0.2f && scale <= 0.25f) {
//            iconNumber = 0.3;
//        }
//        else if (scale > 0.25f && scale <= 0.3f) {
//            iconNumber =0.5;
//        }
//        else if (scale > 0.3f && scale <= 0.35f) {
//            iconNumber = 0.7;
//        }
//        else if (scale > 0.4f && scale <= 0.45f) {
//            iconNumber = 0.9;
//        }
//        else if (scale > 0.45f && scale <= 0.5f) {
//            iconNumber = 1.0;
//        }
//        else if (scale > 0.5f && scale <= 0.55f) {
//            iconNumber = 1.2;
//        }
//        else if (scale > 0.55f && scale <= 0.6f) {
//            iconNumber = 1.4;
//        }
//        else if (scale > 0.6f && scale <= 0.65f) {
//            iconNumber = 1.6;
//        }
//        else if (scale > 0.65f && scale <= 0.7f) {
//            iconNumber = 1.8;
//        }
//        else if (scale > 0.7f && scale <= 0.75f) {
//            iconNumber = 1.9;
//        }
//        else if (scale > 0.75f && scale <= 0.8f) {
//            iconNumber = 2.1;
//        }
//        else  {
//            iconNumber = 0.1;
//        }
//        count = count + 4;
//        CGFloat HightTemp =0;
//        HightTemp = 10;
//        CGFloat hight = scale * 10.0 * HightTemp * iconNumber;
//        
//        if (hight<=0) {
//            hight = 0;
//        }
//        UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(count, kRecordTopHight+ (kRecordBackgroundHeight-hight-kRecordTopHight * 2)/2, 1, hight)];
//        viewBg.backgroundColor = [UIColor lightGrayColor];
//        [_ScrollView addSubview:viewBg];
//        _ScrollView.contentSize = CGSizeMake(count,kRecordBackgroundHeight-kRecordTopHight*2);
//        CGFloat maxMin = count - SCREEN_WIDTH + 40;
//        if (count >= SCREEN_WIDTH - 40) {
//            for ( UIView *subView in _ScrollView.subviews ) {
//                if (subView.frame.origin.x<maxMin) {
//                    [subView removeFromSuperview];
//                }
//            }
//        }
//        _imageShuXian.frame = CGRectMake(count+3, kRecordTopHight, kShuXianWidth, kRecordBackgroundHeight - 2 * kRecordTopHight);
//        CGFloat scrollViewX =  _ScrollView.contentOffset.x;
//        if (count >= SCREEN_WIDTH / 2 - 23) {
//            _imageShuXian.frame = CGRectMake((SCREEN_WIDTH - 45)/2, kRecordTopHight, kShuXianWidth,kRecordBackgroundHeight - 2 * kRecordTopHight);
//            [_imageBg bringSubviewToFront:_imageShuXian];
//            scrollViewX = scrollViewX+6;;
//        }
//        _ScrollView.contentOffset  =CGPointMake (scrollViewX,0);
//    }
//}
//
//-(void)timerAction:(NSTimer *)sender{
//    sliderCurrentValue += 0.1;
//    slider.curretValue = sliderCurrentValue;
//    if (sliderCurrentValue >= 10) {
//        sender.fireDate = [NSDate distantFuture];
//        [audioRecorder stopRecord];
//        self.pressRecordBtn.backgroundColor = [UIColor lightGrayColor];
//        sliderCurrentValue = 0;
//    }
//}
//-(void)back{
//    [self.navigationController popViewControllerAnimated:NO];
//}
//@end
//#import "WWLocationViewController.h"
//@interface WWLocationViewController () <MAMapViewDelegate,XWPresentedOneControllerDelegate,UITableViewDelegate, UITableViewDataSource,AMapSearchDelegate,UITextFieldDelegate>{
//    MAMapView *_mapView;
//    UILabel *_locationLabel;
//    BOOL _canScroll;
//    NSString *_keyWord;
//    CGFloat _currentOffSetY;
//}
//@property (nonatomic, strong) XWInteractiveTransition *interactivePush;
//@property (strong, nonatomic) UITableView *searchTableView;
//@property (strong, nonatomic) UIView *tableBgView;
//@property (strong, nonatomic) NSArray *list;
//@property (nonatomic, strong) AMapSearchAPI *search;
//@end
//
//@implementation WWLocationViewController
//- (UITableView *)searchTableView {
//    if (!_searchTableView) {
//        _searchTableView = [[UITableView alloc] initWithFrame:self.tableBgView.bounds];
//        _searchTableView.delegate = self;
//        _searchTableView.dataSource = self;
//        _searchTableView.scrollEnabled = NO;
//    }
//    return _searchTableView;
//}
//
//- (UIView *)tableBgView {
//    if (!_tableBgView) {
//        _tableBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 70, SCREEN_WIDTH, self.view.height - 100)];
//        _tableBgView.userInteractionEnabled = YES;
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//        [_tableBgView addGestureRecognizer:panGesture];
//    }
//    return _tableBgView;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (_currentOffSetY == 0) {
//        if (scrollView.contentOffset.y < _currentOffSetY) {
//            [self dissmissTableView];
//            _currentOffSetY = 0;
//        }
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    _currentOffSetY = scrollView.contentOffset.y;
//}
//
//- (void)pan:(UIPanGestureRecognizer *)pan {
//    CGPoint translation = [pan translationInView:self.view];
//    switch (pan.state) {
//        case UIGestureRecognizerStateBegan:
//            break;
//        case UIGestureRecognizerStateChanged:
//            
//            _tableBgView.top += translation.y;
//            if (_tableBgView.top <= 120) {
//                _tableBgView.top = 120;
//            }
//            break;
//        case UIGestureRecognizerStateEnded:
//            if (_tableBgView.top >= self.view.height - 100) {
//                [self dissmissTableView];
//            } else {
//                [self showTableView];
//            }
//            [pan setTranslation:CGPointZero inView:self.view];
//            break;
//        default:
//            break;
//    }
//    [pan setTranslation:CGPointZero inView:self.view];
//}
//
//- (void)showTableView {
//    [UIView animateWithDuration:0.4f animations:^{
//        _tableBgView.top = 120;
//    } completion:^(BOOL finished) {
//        _searchTableView.scrollEnabled = YES;
//    }];
//}
//
//- (void)dissmissTableView {
//    [UIView animateWithDuration:0.4f animations:^{
//        _tableBgView.top = self.view.height - 70;
//    } completion:^(BOOL finished) {
//        _searchTableView.scrollEnabled = NO;
//    }];
//}
//- (void)back {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"neirongye_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    leftBarButtonItem.tintColor = UIColorHex(0x7269ff);
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(commit)];
//    barButtonItem.tintColor = UIColorHex(0x7269ff);
//    self.navigationItem.rightBarButtonItem = barButtonItem;
//    [WWLocationManager shareLocationManger].locationSignal = [RACSubject subject];
//    [[WWLocationManager shareLocationManger] startLocation];
//    [[WWLocationManager shareLocationManger].locationSignal subscribeNext:^(NSString * _Nullable address) {
//        _locationLabel.text = address;
//        NSString *fullString = [NSString stringWithFormat:@"当前位置:%@",address];
//        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:fullString];
//        [attributeString setAttributes:@{NSForegroundColorAttributeName:UIColorHex(0x666666)} range:[fullString rangeOfString:@"当前位置:"]];
//        [attributeString setAttributes:@{NSForegroundColorAttributeName:UIColorHex(0x7269ff)} range:[fullString rangeOfString:address]];
//        _locationLabel.attributedText = attributeString;
//    }];
//    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 64, self.view.width - 30, 52)];
//    _locationLabel.backgroundColor = [UIColor whiteColor];
//    _locationLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
//    [self.view addSubview:_locationLabel];
//    [self configMapView];
//    [self.view addSubview:self.tableBgView];
//    [self.tableBgView addSubview:self.searchTableView];
//    
//    [self configTableView];
//}
//
//- (void)configTableView {
//    _search = [[AMapSearchAPI alloc] init];
//    _search.delegate = self;
//    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
//    request.radius = 3000;
//    request.requireExtension = YES;
//    request.location = [AMapGeoPoint locationWithLatitude:30.5673788644 longitude:104.0655469894];
//    [_search AMapPOIAroundSearch:request];
//}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if (_tableBgView.top >= self.view.centerY) {
//        [self showTableView];
//    }
//    return YES;
//}
//- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
//    self.list = response.pois;
//    [self.searchTableView reloadData];
//}
//
//- (void)configMapView {
//    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_locationLabel.frame), self.view.width, self.view.height - CGRectGetMaxY(_locationLabel.frame))];
//    [self.view addSubview:_mapView];
//    _mapView.showsCompass= NO;
//    _mapView.showsScale= NO;
//    _mapView.showsUserLocation = YES;
//    _mapView.delegate = self;
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
//}
//
//- (void)searchWithKeyworkds:(NSString *)keyword {
//    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
//    request.keywords            = keyword;
//    _keyWord = keyword;
//    request.requireExtension    = YES;
//    request.cityLimit           = YES;
//    request.requireSubPOIs      = YES;
//    [self.search AMapPOIKeywordsSearch:request];
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
//    view.backgroundColor = [UIColor whiteColor];
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.center = CGPointMake(view.centerX, 10);
//    imageView.bounds = CGRectMake(0, 0, 39, 6);
//    imageView.image = [UIImage imageNamed:@"fabushuoshuo_shangla"];
//    [view addSubview:imageView];
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(imageView.frame) + 5, self.searchTableView.width - 6, 50)];
//    textField.backgroundColor = [UIColor lightGrayColor];
//    textField.layer.cornerRadius = 5;
//    textField.layer.masksToBounds = YES;
//    [textField setReturnKeyType:UIReturnKeySearch];
//    textField.leftViewMode = UITextFieldViewModeAlways;
//    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
//    textField.text = _keyWord;
//    leftImageView.image = [UIImage imageNamed:@"shuoshuodingwei_search"];
//    textField.leftView = leftImageView;
//    textField.placeholder = @"搜索地点或位置";
//    textField.delegate = self;
//    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        if (x.length > 0) {
//            [self searchWithKeyworkds:x];
//        }
//    }];
//    [view addSubview:textField];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 70;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.list.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    AMapPOI *POI = self.list[indexPath.row];
//    cell.textLabel.text = POI.name;
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    AMapPOI *POI = self.list[indexPath.row];
//    _locationLabel.text = POI.name;
//    [self dissmissTableView];
//}
//@end
//#import "CommentTableViewController.h"
//CGFloat textFieldHeight = 44;
//@interface CommentTableViewController () <UITableViewDelegate, UITableViewDataSource, WWCommentCellDelegate, UITextFieldDelegate> {
//    UITextField *_textField;      //键盘上方的输入框
//    NSIndexPath *_indexPath;      // 当前点击的cell的indexPath
//    CGFloat _totalKeybordHeight;  //键盘的高度 + 键盘上面输入框的高度
//    NSString *_destUserName;
//    NSString *_destUserId;
//    
//}
//@property (nonatomic , strong) NSMutableArray *dataArray;
//@property (strong, nonatomic) UITableView *tableView;
//@end
//@implementation CommentTableViewController
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"neirongye_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    leftBarButtonItem.tintColor = UIColorHex(0x7269ff);
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
//    self.view.top = 64;
//    self.view.height -= 64;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    [self.view addSubview:self.tableView];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.sectionFooterHeight = 0.01;
//    
//    self.tableView.estimatedRowHeight = 60;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.dataArray = [self createModelsWithData].mutableCopy;
//    [self setupTextField];
//    
//}
//- (void)back {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (void)setupTextField {
//    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, textFieldHeight)];
//    _textField.returnKeyType = UIReturnKeyDone;
//    _textField.backgroundColor = [UIColor lightGrayColor];
//    _textField.delegate = self;
//    [self.view addSubview:_textField];
//    [self.view insertSubview:_textField aboveSubview:self.tableView];
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification * _Nullable noti) {
//        NSDictionary *dict = noti.userInfo;
//        CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//        CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldHeight, [UIScreen mainScreen].bounds.size.width, textFieldHeight);
//        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
//            textFieldRect = rect;
//        }
//        [UIView animateWithDuration:0.25 animations:^{
//            _textField.frame = textFieldRect;
//        }];
//        CGFloat h = rect.size.height + textFieldHeight;
//        if (_totalKeybordHeight != h) {
//            _totalKeybordHeight = h;
//            NSLog(@"---%lf",_totalKeybordHeight);
//            [self adjustTableViewToFitKeyboard];
//        }
//    }];
//}
//- (void)adjustTableViewToFitKeyboard {
//    WWCommentCell *cell = [_tableView cellForRowAtIndexPath:_indexPath];
//    CGRect rect = [cell.superview convertRect:cell.frame toView:self.view];
//    [self adjustTableViewToFitKeyboardWithRect:rect];
//}
//
//- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect {
//    CGFloat delta = CGRectGetMaxY(rect) - (self.view.bounds.size.height - _totalKeybordHeight);
//    CGPoint offSet = _tableView.contentOffset;
//    offSet.y += delta;
//    if (offSet.y < 0) {
//        offSet.y = 0;
//    }
//    [_tableView setContentOffset:offSet animated:YES];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:NO];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:YES];
//}
//
//- (NSArray *)createModelsWithData {
//    NSMutableArray *resArr = [NSMutableArray new];
//    for (int i = 0; i < 5; i++) {
//        WWCommentModel *model = [[WWCommentModel alloc] init];
//        model.iconName =iconImageNamesArray[i];
//        model.name = namesArray[i];
//        model.msgContent = textArray[i];
//        NSMutableArray *tempComments = [NSMutableArray new];
//        for (int i = 0; i < 5; i++) {
//            WWCommentItemModel *commentItemModel = [WWCommentItemModel new];
//            commentItemModel.firstUserName = namesArray[i];
//            commentItemModel.firstUserId = @"666";
//            commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
//            commentItemModel.secondUserId = @"888";
//            commentItemModel.commentString = @"经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真";
//            [tempComments addObject:commentItemModel];
//        }
//        model.commentItemsArray = [tempComments copy];
//        [resArr addObject:model];
//    }
//    return resArr;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    WWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WWCommentCell"];
//    cell.indexPath = indexPath;
//    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"WWCommentCell" owner:nil options:nil].firstObject;
//    }
//    cell.delegate = self;
//    WWCommentModel *itemModel = self.dataArray[indexPath.section];
//    cell.model = itemModel.commentItemsArray[indexPath.row];
//    return cell;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    WWCommentModel *itemModel = self.dataArray[section];
//    return itemModel.commentItemsArray.count;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.dataArray.count;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    WWCommentHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WWCommentHeaderView class]) owner:nil options:nil].firstObject;
//    headerView.tag = 100 + section;
//    headerView.commentModel = self.dataArray[section];
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick:)];
//    [headerView addGestureRecognizer:gesture];
//    return headerView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    WWCommentHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WWCommentHeaderView class]) owner:nil options:nil].firstObject;
//    return [headerView configHeaderViewHeightWithContent:self.dataArray[section]];
//}
//
//- (void)didClickUserNameInCell:(WWCommentCell *)cell withUserName:(NSString *)userName{
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    _indexPath = indexPath;
//    _textField.placeholder = [NSString stringWithFormat:@"@%@",userName];
//    _destUserName = userName;
//    _destUserId = @"2";
//    [_textField becomeFirstResponder];
//}
//
//- (void)headerViewClick:(UITapGestureRecognizer *)gesture {
//    WWCommentHeaderView *headerView = (WWCommentHeaderView *)gesture.view;
//    WWCommentModel *model = self.dataArray[headerView.tag - 100];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:headerView.tag - 100];
//    NSLog(@"---%@",model.name);
//    _destUserName = model.name;
//    _destUserId = @"2";
//    _textField.placeholder = [NSString stringWithFormat:@"@%@",model.name];
//    _indexPath = indexPath;
//    [_textField becomeFirstResponder];
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    WWCommentModel *commentModel = self.dataArray[_indexPath.section];
//    WWCommentItemModel *itemModel = [[WWCommentItemModel alloc] init];
//    itemModel.firstUserName = @"我";
//    itemModel.firstUserId = @"1";
//    itemModel.secondUserName = _destUserName;
//    itemModel.secondUserId = _destUserId;
//    itemModel.commentString = textField.text;
//    NSMutableArray *muArray = commentModel.commentItemsArray.mutableCopy;
//    [muArray insertObject:itemModel atIndex:0];
//    commentModel.commentItemsArray = muArray;
//    [self.tableView reloadSections:@[_indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    return YES;
//}
//@end
//#import "WWPublishTalkViewController.h"
//@interface WWPublishTalkViewController (){
//    UILabel *titleLabel;
//    VBTextView  *storyTextView;
//    UIView  *line1;
//    UILabel *subTitleLabel;
//    WWTagEditingView  *edtingView;
//    UIView  *line2;
//    UIView  *chargeBtnBackGroundView;
//    UIButton *freeChargeBtn;
//    UIButton *chargeBtn;
//    UIButton *okBtn;
//    WWChargeTextField *chargeTextField;
//    UIView  *line3;
//    UIView  *withBtnBackGroundView;
//    UIButton  *withButton;
//    UIButton  *addAudioBtn;
//    UIButton *locationBtn;
//    UIButton  *submitBtn;
//    UIImage *windowImage;
//}
//@property (nonatomic, strong) NSString *location;
//@end
//
//@implementation WWPublishTalkViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.manager = [HXPhotoManager sharedManager];
//    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    windowImage = appdelegate.drawView.image;
//    if (!self.isVideo) {
//        [HXPhotoTools fetchHDImageForSelectedPhoto:self.manager.selectedList completion:^(NSArray<UIImage *> *images) {
//            UIImage *backGroundImage = images.firstObject;
//            appdelegate.drawView.image = backGroundImage;
//        }];
//    }
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bianji_Close"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
//    label.textColor = [UIColor colorWithHexString:@"ffffff"];
//    label.text = @"编辑你的故事";
//    label.font = DDPingFangSCMediumFONT(17);
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
//    self.location = @"益州大道1700号环球中心肯德基环球店 ";
//    [self configView];
//    [self addConstraints];
//    [self configSELAction];
//}
//
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    withButton.frame = CGRectMake(0, 0, 45, 20);
//    addAudioBtn.frame = CGRectMake(68, 0, 110, 20);
//    okBtn.frame = CGRectMake(chargeTextField.frame.origin.x + 100, 32, 45, 20);
//    [withButton setTitle:@"with" forState:UIControlStateNormal];
//    [addAudioBtn setTitle:@"给照片贴上声音" forState:UIControlStateNormal];
//    [submitBtn setTitle:@"发布" forState:UIControlStateNormal];
//    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [self configGradientButton:withButton];
//    [self configGradientButton:addAudioBtn];
//    [self configGradientButton:submitBtn];
//    [self configGradientButton:okBtn];
//}
//-(void)chargeBtnClickAtion:(UIButton *)sender{
//    sender.selected = YES;
//    freeChargeBtn.selected = NO;
//    okBtn.hidden = NO;
//    chargeTextField.hidden = NO;
//    [chargeBtnBackGroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//        make.top.equalTo(line2.mas_bottom).offset(kTopBottomMargin);
//        make.height.mas_equalTo(54);
//    }];
//    
//    [locationBtn setTitle:self.location forState:UIControlStateNormal];
//    CGSize locationLabelSize = [self.location sizeWithAttributes:@{NSFontAttributeName:DDPingFangSCMediumFONT(12)}];
//    
//    [locationBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.equalTo(withBtnBackGroundView.mas_bottom).offset(kTopBottomMargin);
//        make.width.mas_equalTo(locationLabelSize.width + 38);
//        make.height.mas_equalTo(20);
//    }];
//    
//    [self.view layoutIfNeeded];
//}
//-(void)freeChargeBtnClickAction:(UIButton *)sender{
//    sender.selected = YES;
//    chargeBtn.selected = NO;
//    okBtn.hidden = YES;
//    chargeTextField.hidden = YES;
//    [chargeBtnBackGroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//        make.top.equalTo(line2.mas_bottom).offset(kTopBottomMargin);
//        make.height.mas_equalTo(32);
//    }];
//    [locationBtn setTitle:@"你在哪里？" forState:UIControlStateNormal];
//    [locationBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.equalTo(withBtnBackGroundView.mas_bottom).offset(kTopBottomMargin);
//        make.width.mas_equalTo(90);
//        make.height.mas_equalTo(20);
//    }];
//    [self.view layoutIfNeeded];
//}
//
//-(void)audioBtnClickAction:(UIButton *)sender{
//    WWAudioRecorderViewController *audioRecordVC = [[WWAudioRecorderViewController alloc] init];
//    [self.navigationController pushViewController:audioRecordVC animated:NO];
//}
//
//-(void)withBtnAction:(UIButton *)sender{
//    WWWithLocationViewController *withVC = [[WWWithLocationViewController alloc] init];
//    [self.navigationController pushViewController:withVC animated:NO];
//}
//
//-(void)locationBtnAction:(UIButton *)sender{
//    WWLocationViewController *locationVC = [[WWLocationViewController alloc] init];
//    [self.navigationController pushViewController:locationVC animated:NO];
//}
//
//-(void)configSELAction{
//    [chargeBtn addTarget:self action:@selector(chargeBtnClickAtion:) forControlEvents:UIControlEventTouchUpInside];
//    [freeChargeBtn addTarget:self action:@selector(freeChargeBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [okBtn addTarget:self action:@selector(okBtnClickAtion:) forControlEvents:UIControlEventTouchUpInside];
//    [addAudioBtn addTarget:self action:@selector(audioBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [withButton addTarget:self action:@selector(withBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [locationBtn addTarget:self action:@selector(locationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//-(void)configView{
//    titleLabel = [UILabel new];
//    [self.view addSubview:titleLabel];
//    titleLabel.text = @"写故事";
//    [self configLabel:titleLabel];
//    
//    storyTextView = [VBTextView new];
//    storyTextView.placeColor = [UIColor colorWithHexString:@"e5e5e5"];
//    storyTextView.placeHolder = @"请输入新故事...";
//    storyTextView.backgroundColor = [UIColor clearColor];
//    storyTextView.font = DDPingFangSCMediumFONT(14);
//    storyTextView.infoColor = [UIColor colorWithHexString:@"ffffff"];
//    [self.view addSubview:storyTextView];
//    
//    line1 = [UIView new];
//    [self.view addSubview:line1];
//    line1.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//    
//    subTitleLabel = [UILabel new];
//    [self.view addSubview:subTitleLabel];
//    subTitleLabel.text = @"给故事贴上标签";
//    [self configLabel:subTitleLabel];
//    
//    edtingView = [WWTagEditingView new];
//    [self.view addSubview:edtingView];
//    
//    line2 = [UIView new];
//    [self.view addSubview:line2];
//    line2.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//    
//    chargeBtnBackGroundView = [UIView new];
//    [self.view addSubview:chargeBtnBackGroundView];
//    
//    freeChargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chargeBtnBackGroundView addSubview:freeChargeBtn];
//    [freeChargeBtn setImage:[UIImage imageNamed:@"bianji_weixuanzhong"] forState:UIControlStateNormal];
//    [freeChargeBtn setImage:[UIImage imageNamed:@"bianji_xuanzhong"] forState:UIControlStateSelected];
//    [freeChargeBtn setTitle: @"免费" forState:UIControlStateNormal];
//    freeChargeBtn.titleLabel.font = DDPingFangSCMediumFONT(12);
//    [freeChargeBtn  setTintColor:[UIColor ww_ColorWithHexString:@"ffffff"]];
//    [freeChargeBtn setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:8];
//    
//    chargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chargeBtnBackGroundView addSubview:chargeBtn];
//    [chargeBtn setImage:[UIImage imageNamed:@"bianji_weixuanzhong"] forState:UIControlStateNormal];
//    [chargeBtn setImage:[UIImage imageNamed:@"bianji_xuanzhong"] forState:UIControlStateSelected];
//    [chargeBtn setTitle: @"收费" forState:UIControlStateNormal];
//    chargeBtn.titleLabel.font = DDPingFangSCMediumFONT(12);
//    [chargeBtn  setTintColor:[UIColor ww_ColorWithHexString:@"ffffff"]];
//    [chargeBtn setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:8];
//    
//    chargeTextField = [[WWChargeTextField alloc] init];
//    [chargeBtnBackGroundView addSubview:chargeTextField];
//    chargeTextField.textAlignment = NSTextAlignmentCenter;
//    
//    chargeTextField.backgroundColor = [UIColor clearColor];
//    chargeTextField.format = @"XX";
//    NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"1-99" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"e5e5e5"]}];
//    chargeTextField.attributedPlaceholder = placeHolder;
//    chargeTextField.font = DDPingFangSCMediumFONT(12);
//    chargeTextField.textColor = [UIColor colorWithHexString:@"fffa69"];
//    chargeTextField.layer.borderWidth = 1;
//    chargeTextField.layer.cornerRadius = 10;
//    chargeTextField.layer.masksToBounds = YES;
//    chargeTextField.layer.borderColor = [UIColor ww_ColorWithHexString:@"ffffff" alpha:0.3].CGColor;
//    [chargeTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
//    chargeTextField.hidden = YES;
//    chargeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chargeBtnBackGroundView addSubview:okBtn];
//    okBtn.hidden = YES;
//    
//    line3 = [UIView new];
//    [self.view addSubview:line3];
//    line3.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//    
//    withBtnBackGroundView = [UIView new];
//    [self.view addSubview:withBtnBackGroundView];
//    
//    withButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [withBtnBackGroundView addSubview: withButton];
//    
//    addAudioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [withBtnBackGroundView addSubview: addAudioBtn];
//    
//    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:locationBtn];
//    [locationBtn setImage:[UIImage imageNamed:@"bianji_dingwei"] forState:UIControlStateNormal];
//    [locationBtn setTitle: @"你在哪里？" forState:UIControlStateNormal];
//    locationBtn.titleLabel.font = DDPingFangSCMediumFONT(12);
//    [locationBtn  setTintColor:[UIColor ww_ColorWithHexString:@"e5e5e5"]];
//    [locationBtn setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:8];
//    locationBtn.layer.cornerRadius = 10;
//    locationBtn.layer.masksToBounds = YES;
//    locationBtn.layer.borderWidth = 0.5;
//    locationBtn.layer.borderColor = [UIColor ww_ColorWithHexString:@"e5e5e5" alpha:0.3].CGColor;
//    submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    submitBtn.frame = CGRectMake(0, 0, 300, 34);
//    [self.view addSubview:submitBtn];
//    submitBtn.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT - 90);
//}
//
//-(void)configLabel:(UILabel *)label{
//    label.font = DDPingFangSCMediumFONT(17);
//    label.textColor = [UIColor colorWithHexString:@"7269ff"];
//    label.textAlignment = NSTextAlignmentLeft;
//    label.preferredMaxLayoutWidth = (self.view.frame.size.width - kLeadingMargin * 2);
//    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    label.numberOfLines =0;
//}
//
//-(void)configGradientButton :(UIButton *)button{
//    [button setTintColor:[UIColor colorWithHexString:@"ffffff"]];
//    button.titleLabel.font = DDPingFangSCMediumFONT(12);
//    button.layer.cornerRadius = button.bounds.size.height / 2;
//    button.layer.masksToBounds = YES;
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:115/255.0 green:111/255.0 blue:251/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:119/255.0 green:167/255.0 blue:247/255.0 alpha:1].CGColor];
//    gradientLayer.locations = @[@0.1, @0.9];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1.0, 0);
//    gradientLayer.frame = button.bounds;
//    [button.layer insertSublayer:gradientLayer below:button.titleLabel.layer];
//}
//
//-(void)addConstraints{
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.mas_equalTo(kRELATIVE_H(70));
//    }];
//    [storyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//        make.top.equalTo(titleLabel.mas_bottom).offset(kTopBottomMargin);
//        make.height.mas_equalTo(kRELATIVE_H(80));
//    }];
//    
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.equalTo(storyTextView.mas_bottom).offset(kTopBottomMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//        make.height.mas_equalTo(1);
//    }];
//    
//    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.equalTo(line1.mas_bottom).offset(kTopBottomMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//    }];
//    
//    [edtingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//        make.top.equalTo(subTitleLabel.mas_bottom).offset(kTopBottomMargin);
//        make.height.mas_equalTo(kRELATIVE_H(30));
//    }];
//    
//    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.equalTo(edtingView.mas_bottom).offset(kTopBottomMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//        make.height.mas_equalTo(1);
//    }];
//    
//    [chargeBtnBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//        make.top.equalTo(line2.mas_bottom).offset(kTopBottomMargin);
//        make.height.mas_equalTo(22);
//    }];
//    
//    [freeChargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(chargeBtnBackGroundView);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(55);
//    }];
//    
//    [chargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(freeChargeBtn.mas_right).offset(10);
//        make.top.equalTo(chargeBtnBackGroundView);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(55);
//    }];
//    
//    [chargeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(chargeBtnBackGroundView);
//        make.top.equalTo(freeChargeBtn.mas_bottom).offset(12);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(85);
//    }];
//    
//    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.equalTo(chargeBtnBackGroundView.mas_bottom).offset(kTopBottomMargin);
//        make.right.mas_equalTo(-kTopBottomMargin);
//        make.height.mas_equalTo(1);
//    }];
//    
//    [withBtnBackGroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.equalTo(line3.mas_bottom).offset(kTopBottomMargin);
//        make.right.mas_equalTo(-kLeadingMargin);
//        make.height.mas_equalTo(20);
//    }];
//    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kLeadingMargin);
//        make.top.equalTo(withBtnBackGroundView.mas_bottom).offset(kTopBottomMargin);
//        make.width.mas_equalTo(90);
//        make.height.mas_equalTo(20);
//    }];
//}
//
//#pragma mark  - UITextField events
//- (void)textDidChange:(UITextField *)textField
//{
//    NSLog(@"textField.placeholder %@ textDidChange %@", textField.placeholder, textField.text);
//}
//
//-(void)back{
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[WWStroyIndexViewController class]]) {
//            WWStroyIndexViewController *VC =(WWStroyIndexViewController *)controller;
//            [self.navigationController popToViewController:VC animated:YES];
//        }
//    }
//}
//
//- (void)compressedVideoWithURL:(id)url success:(void(^)(NSString *fileName))success failure:(void(^)())failure
//{
//    AVURLAsset *avAsset;
//    if ([url isKindOfClass:[NSURL class]]) {
//        avAsset = [AVURLAsset assetWithURL:url];
//    }else if ([url isKindOfClass:[AVAsset class]]) {
//        avAsset = (AVURLAsset *)url;
//    }
//    
//    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
//    
//    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
//        
//        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
//        NSString *fileName = @"";
//        NSDate *nowDate = [NSDate date];
//        NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[nowDate timeIntervalSince1970]];
//        
//        NSString *numStr = [NSString stringWithFormat:@"%d",arc4random()%10000];
//        fileName = [fileName stringByAppendingString:dateStr];
//        fileName = [fileName stringByAppendingString:numStr];
//        fileName = [fileName stringByAppendingString:@".mp4"];
//        NSString *fileName1 = [NSTemporaryDirectory() stringByAppendingString:fileName];
//        exportSession.outputURL = [NSURL fileURLWithPath:fileName1];
//        exportSession.outputFileType = AVFileTypeMPEG4;
//        exportSession.shouldOptimizeForNetworkUse = YES;
//        
//        [exportSession exportAsynchronouslyWithCompletionHandler:^{
//            
//            switch (exportSession.status) {
//                case AVAssetExportSessionStatusCancelled:
//                    break;
//                case AVAssetExportSessionStatusCompleted:
//                {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (success) {
//                            success(fileName1);
//                        }
//                    });
//                }
//                    break;
//                case AVAssetExportSessionStatusExporting:
//                    break;
//                case AVAssetExportSessionStatusFailed:
//                {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (failure) {
//                            failure();
//                        }
//                    });
//                }
//                    break;
//                case AVAssetExportSessionStatusUnknown:
//                    break;
//                case AVAssetExportSessionStatusWaiting:
//                    break;
//                default:
//                    break;
//            }
//        }];
//    }
//}
//@end
//#import "WWOtherHomeViewController.h"
//@interface WWOtherHomeViewController () <UITableViewDelegate, UITableViewDataSource>{
//    BOOL _isFriend;
//}
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewTop;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;
//@property (nonatomic, weak) IBOutlet WWOtherHomeHeaderView *headerView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *portraitTopConstraint;
//@property (weak, nonatomic) IBOutlet UIButton *leftButton;
//@property (weak, nonatomic) IBOutlet UIButton *rightButton;
//@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
//@property (weak, nonatomic) IBOutlet UIButton *portraitButton;
//@end
//@implementation WWOtherHomeViewController
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"drag"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
//    self.navigationItem.rightBarButtonItem = item;
//    [self configTableView];
//    if (!self.user) {
//        [self.leftButton setImage:[UIImage imageNamed:@"wallet"] forState:UIControlStateNormal];
//        [self.rightButton setImage:[UIImage imageNamed:@"Contacts"] forState:UIControlStateNormal];
//        [self.portraitButton sd_setImageWithURL:[NSURL URLWithString:[WWAccountManager getAccount].headImg] forState:UIControlStateNormal];
//        self.usernameLabel.text = [[WWAccountManager getAccount] nickname];
//        self.view.layer.contents = (__bridge id _Nullable)([[WWGlobalSet globalSet] otherHomeBackgroundImage].CGImage);
//    } else {
//        [self.portraitButton sd_setImageWithURL:[NSURL URLWithString:self.user.headImg] forState:UIControlStateNormal];
//        self.usernameLabel.text = self.user.nickname;
//        
//    }
//    if (self.user) {
//        [self request];
//    }
//    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self sendMessage];
//    }];
//    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self addFriend];
//    }];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"refreshOtherHome" object:nil];
//}
//- (void)configTableView {
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.tableView.contentInset = UIEdgeInsetsMake(kFloatingViewMaximumHeight, 0, 0, 0);
//    self.tableView.rowHeight = 240;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint offset = scrollView.contentOffset;
//    if (offset.y <= 0 && -offset.y >= kFloatingViewMaximumHeight) {
//        self.headerViewTop.constant = -offset.y - kFloatingViewMaximumHeight;
//    } else if (offset.y < 0 && -offset.y < kFloatingViewMaximumHeight && -offset.y > kFloatingViewMinimumHeight) {
//        self.headerViewTop.constant = -offset.y - kFloatingViewMaximumHeight;
//        self.leftButton.top = (-offset.y - kFloatingViewMaximumHeight) / 2;
//        self.rightButton.top = (-offset.y - kFloatingViewMaximumHeight) / 2;
//        self.portraitTopConstraint.constant = 86 - (-offset.y - kFloatingViewMaximumHeight);
//        if (self.portraitTopConstraint.constant >= 130) {
//            self.portraitTopConstraint.constant = 130;
//        }
//    } else {
//        self.headerViewTop.constant = kFloatingViewMinimumHeight - kFloatingViewMaximumHeight;
//    }
//}
//
//- (void)reload:(NSNotification *)object{
//    [self.portraitButton sd_setImageWithURL:[NSURL URLWithString:object.object] forState:UIControlStateNormal];
//}
//- (void)request {
//    [DDNetworkHelper POST:@"user/findUserMessage" parameters:@{@"userId":[WWAccountManager getAccount].id,@"friendId":self.user.id} success:^(id responseObject) {
//        if ([responseObject[@"code"] isEqualToString:@"1"]) {
//            [self updateView:responseObject];
//        } else {
//            [NSObject showHudTipStr:@"获取失败"];
//        }
//    } failure:^(NSError *error) {
//    }];
//}
//
//- (void)updateView:(NSDictionary *)responseObject {
//    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:responseObject[@"data"][@"name"]].CGImage);
//    if ([[responseObject[@"data"][@"isFriend"] description] isEqualToString:@"1"]) { //好友关系
//        [self.rightButton setImage:[UIImage imageNamed:@"zhuyejiahaoyou"] forState:UIControlStateNormal];
//        
//        _isFriend = YES;
//    }
//}
//
//- (void)setting {
//    if (!self.user) {
//        @weakify(self);
//        CustomAlertController *alertController = [CustomAlertController zm_alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet actionTitles:@[@"个人资料",@"封面背景"] cancelTitle:@"取消" actionClickBlock:^(NSUInteger index) {
//            @strongify(self);
//            if (index == 0) {
//                WWPersonalInfoViewController *personalInfoVC = [[WWPersonalInfoViewController alloc] init];
//                [self.navigationController pushViewController:personalInfoVC animated:YES];
//            } else if (index == 1) {
//                WWSelectThemeBgViewController *selectThemeBgVC = [[WWSelectThemeBgViewController alloc] init];
//                selectThemeBgVC.selectType = TypeOtherHome;
//                selectThemeBgVC.selectBgImageView = ^(UIImage *image, SelectType type) {
//                    self.view.layer.contents = (__bridge id _Nullable)image.CGImage;
//                    [[WWGlobalSet globalSet] setOtherHomeBackgroundImage:image];
//                };
//                [self.navigationController pushViewController:selectThemeBgVC animated:YES];
//            }
//        }];
//        [self presentViewController:alertController animated:YES completion:nil];
//    } else {
//        CustomAlertController *alertController = [CustomAlertController zm_alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet actionTitles:@[@"举报",@"加入黑名单"] cancelTitle:@"取消" actionClickBlock:^(NSUInteger index) {
//            if (index == 0) {
//                [self reportUser];
//            } else if (index == 1) {
//                [self addUserToBlackList];
//            }
//            NSLog(@"%ld",index);
//        }];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//}
//
//- (void)reportUser {
//    [DDNetworkHelper POST:@"user/userReport" parameters:@{@"userId":[WWAccountManager getAccount].id,@"byUserReportId":self.user.id} success:^(id responseObject) {
//        if ([responseObject[@"code"] isEqualToString:@"1"]) {
//            [NSObject showHudTipStr:@"举报成功"];
//        } else {
//            [NSObject showHudTipStr:@"举报失败"];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//}
//
//- (void)addUserToBlackList {
//    [DDNetworkHelper POST:@"user/addUserBlackList" parameters:@{@"userId":[WWAccountManager getAccount].id,@"friendId":self.user.id} success:^(id responseObject) {
//        if ([responseObject[@"code"] isEqualToString:@"1"]) {
//            [[RCIMClient sharedRCIMClient] addToBlacklist:self.user.id success:^{
//                [NSObject showHudTipStr:@"加入黑名单成功"];
//            } error:^(RCErrorCode status) {
//                
//            }];
//        } else {
//            [NSObject showHudTipStr:@"加入黑名单失败"];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//}
//
//- (IBAction)addFriend {
//    if (!self.user) {
//        WWFriendListViewController *friendListVC = [[WWFriendListViewController alloc] init];
//        [self.navigationController pushViewController:friendListVC animated:YES];
//    } else {
//        if (_isFriend) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除好友" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *comfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                [DDNetworkHelper POST:@"user/deleteImfriend" parameters:@{@"userId":[WWAccountManager getAccount].id,@"friendId":self.user.id} success:^(id responseObject) {
//                    if ([responseObject[@"code"] isEqualToString:@"1"]) {
//                        [NSObject showHudTipStr:@"删除好友成功"];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFriendListNotification" object:nil];
//                        [self.navigationController popViewControllerAnimated:YES];
//                    } else {
//                        [NSObject showHudTipStr:@"删除失败"];
//                    }
//                } failure:^(NSError *error) {
//                }];
//            }];
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
//            [alertController addAction:comfirm];
//            [alertController addAction:cancel];
//            [self presentViewController:alertController animated:YES completion:nil];
//        } else {
//            WWAddFriendViewController *addFriendVC = [[WWAddFriendViewController alloc] init];
//            addFriendVC.friendId = self.user.id;
//            [self.navigationController pushViewController:addFriendVC animated:YES];
//        }
//    }
//}
//- (IBAction)sendMessage {
//    if (!self.user) {
//        WWAccountViewController *account = [[WWAccountViewController alloc] init];
//        [self.navigationController pushViewController:account animated:YES];
//    } else {
//        WWChatViewController *chatVC = [[WWChatViewController alloc] init];
//        chatVC.conversationType = ConversationType_PRIVATE;
//        chatVC.targetId = self.user.id;
//        [self.navigationController pushViewController:chatVC animated:YES];
//    }
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    WWStoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"WWStoryListCell" owner:nil options:nil].firstObject;
//    }
//    if (indexPath.row % 2 == 0) {
//        cell.type = @"1";
//    } else if (indexPath.row % 3 == 0) {
//        cell.type = @"2";
//    } else {
//        cell.type = @"0";
//    }
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        WWPhotoCommentViewController *photoCommentVC = [[WWPhotoCommentViewController alloc] init];
//        [self.navigationController pushViewController:photoCommentVC animated:YES];
//    }else {
//        WWVideoCommentViewController *videoCommentVC = [[WWVideoCommentViewController alloc] init];
//        [self.navigationController pushViewController:videoCommentVC animated:YES];
//    }
//}
//@end
//@interface WWOtherHomeViewController () <UITableViewDelegate, UITableViewDataSource>{
//    BOOL _isFriend;
//}
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewTop;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;
//@property (nonatomic, weak) IBOutlet WWOtherHomeHeaderView *headerView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *portraitTopConstraint;
//@property (weak, nonatomic) IBOutlet UIButton *leftButton;
//@property (weak, nonatomic) IBOutlet UIButton *rightButton;
//@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
//@property (weak, nonatomic) IBOutlet UIButton *portraitButton;
//
//@end
//
//@implementation WWOtherHomeViewController
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"drag"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
//    self.navigationItem.rightBarButtonItem = item;
//    [self configTableView];
//    if (!self.user) {
//        [self.leftButton setImage:[UIImage imageNamed:@"wallet"] forState:UIControlStateNormal];
//        [self.rightButton setImage:[UIImage imageNamed:@"Contacts"] forState:UIControlStateNormal];
//        [self.portraitButton sd_setImageWithURL:[NSURL URLWithString:[WWAccountManager getAccount].headImg] forState:UIControlStateNormal];
//        self.usernameLabel.text = [[WWAccountManager getAccount] nickname];
//        self.view.layer.contents = (__bridge id _Nullable)([[WWGlobalSet globalSet] otherHomeBackgroundImage].CGImage);
//    } else {
//        [self.portraitButton sd_setImageWithURL:[NSURL URLWithString:self.user.headImg] forState:UIControlStateNormal];
//        self.usernameLabel.text = self.user.nickname;
//        
//    }
//    if (self.user) {
//        [self request];
//    }
//    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self sendMessage];
//    }];
//    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self addFriend];
//    }];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"refreshOtherHome" object:nil];
//    
//    
//}
//
//- (void)configTableView {
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.tableView.contentInset = UIEdgeInsetsMake(kFloatingViewMaximumHeight, 0, 0, 0);
//    self.tableView.rowHeight = 240;
//    //    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint offset = scrollView.contentOffset;
//    if (offset.y <= 0 && -offset.y >= kFloatingViewMaximumHeight) {
//        self.headerViewTop.constant = -offset.y - kFloatingViewMaximumHeight;
//    } else if (offset.y < 0 && -offset.y < kFloatingViewMaximumHeight && -offset.y > kFloatingViewMinimumHeight) {
//        self.headerViewTop.constant = -offset.y - kFloatingViewMaximumHeight;
//        self.leftButton.top = (-offset.y - kFloatingViewMaximumHeight) / 2;
//        self.rightButton.top = (-offset.y - kFloatingViewMaximumHeight) / 2;
//        //        if (self.portraitBottomConstraint.constant >= 70) {
//        //                self.portraitBottomConstraint.constant = 134 + (-offset.y - kFloatingViewMaximumHeight);
//        //        }
//        self.portraitTopConstraint.constant = 86 - (-offset.y - kFloatingViewMaximumHeight);
//        if (self.portraitTopConstraint.constant >= 130) {
//            self.portraitTopConstraint.constant = 130;
//        }
//        //        self.bottomButtonVerticalConstraint.constant = MAX(-72, self.bottomButtonVerticalConstraint.constant);
//    } else {
//        self.headerViewTop.constant = kFloatingViewMinimumHeight - kFloatingViewMaximumHeight;
//        //
//        //        [UIView animateWithDuration:0.3 animations:^{
//        //            self.portraitTopConstraint.constant += 50;
//        //        }];
//        
//    }
//    
//}
//
//
//
//
//
//- (void)reload:(NSNotification *)object{
//    
//    [self.portraitButton sd_setImageWithURL:[NSURL URLWithString:object.object] forState:UIControlStateNormal];
//}
//- (void)request {
//    [DDNetworkHelper POST:@"user/findUserMessage" parameters:@{@"userId":[WWAccountManager getAccount].id,@"friendId":self.user.id} success:^(id responseObject) {
//        if ([responseObject[@"code"] isEqualToString:@"1"]) {
//            [self updateView:responseObject];
//        } else {
//            [NSObject showHudTipStr:@"获取失败"];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//    
//}
//
//- (void)updateView:(NSDictionary *)responseObject {
//    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:responseObject[@"data"][@"name"]].CGImage);
//    if ([[responseObject[@"data"][@"isFriend"] description] isEqualToString:@"1"]) { //好友关系
//        [self.rightButton setImage:[UIImage imageNamed:@"zhuyejiahaoyou"] forState:UIControlStateNormal];
//        
//        _isFriend = YES;
//    }
//}
//
//
//
//
//- (void)detail {
//    
//}
//
//
//- (void)setting {
//    if (!self.user) {
//        @weakify(self);
//        CustomAlertController *alertController = [CustomAlertController zm_alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet actionTitles:@[@"个人资料",@"封面背景"] cancelTitle:@"取消" actionClickBlock:^(NSUInteger index) {
//            @strongify(self);
//            if (index == 0) {
//                WWPersonalInfoViewController *personalInfoVC = [[WWPersonalInfoViewController alloc] init];
//                [self.navigationController pushViewController:personalInfoVC animated:YES];
//            } else if (index == 1) {
//                WWSelectThemeBgViewController *selectThemeBgVC = [[WWSelectThemeBgViewController alloc] init];
//                selectThemeBgVC.selectType = TypeOtherHome;
//                selectThemeBgVC.selectBgImageView = ^(UIImage *image, SelectType type) {
//                    self.view.layer.contents = (__bridge id _Nullable)image.CGImage;
//                    [[WWGlobalSet globalSet] setOtherHomeBackgroundImage:image];
//                };
//                [self.navigationController pushViewController:selectThemeBgVC animated:YES];
//            }
//        }];
//        [self presentViewController:alertController animated:YES completion:nil];
//    } else {
//        CustomAlertController *alertController = [CustomAlertController zm_alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet actionTitles:@[@"举报",@"加入黑名单"] cancelTitle:@"取消" actionClickBlock:^(NSUInteger index) {
//            if (index == 0) {
//                [self reportUser];
//            } else if (index == 1) {
//                [self addUserToBlackList];
//            }
//            NSLog(@"%ld",index);
//        }];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//}
//
//
//- (void)reportUser {
//    [DDNetworkHelper POST:@"user/userReport" parameters:@{@"userId":[WWAccountManager getAccount].id,@"byUserReportId":self.user.id} success:^(id responseObject) {
//        if ([responseObject[@"code"] isEqualToString:@"1"]) {
//            [NSObject showHudTipStr:@"举报成功"];
//        } else {
//            [NSObject showHudTipStr:@"举报失败"];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//}
//
//- (void)addUserToBlackList {
//    [DDNetworkHelper POST:@"user/addUserBlackList" parameters:@{@"userId":[WWAccountManager getAccount].id,@"friendId":self.user.id} success:^(id responseObject) {
//        if ([responseObject[@"code"] isEqualToString:@"1"]) {
//            [[RCIMClient sharedRCIMClient] addToBlacklist:self.user.id success:^{
//                [NSObject showHudTipStr:@"加入黑名单成功"];
//            } error:^(RCErrorCode status) {
//                
//            }];
//        } else {
//            [NSObject showHudTipStr:@"加入黑名单失败"];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//}
//
//
//- (IBAction)addFriend {
//    //如果是自己
//    if (!self.user) {
//        WWFriendListViewController *friendListVC = [[WWFriendListViewController alloc] init];
//        [self.navigationController pushViewController:friendListVC animated:YES];
//    } else {
//        if (_isFriend) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除好友" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *comfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                [DDNetworkHelper POST:@"user/deleteImfriend" parameters:@{@"userId":[WWAccountManager getAccount].id,@"friendId":self.user.id} success:^(id responseObject) {
//                    if ([responseObject[@"code"] isEqualToString:@"1"]) {
//                        [NSObject showHudTipStr:@"删除好友成功"];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFriendListNotification" object:nil];
//                        [self.navigationController popViewControllerAnimated:YES];
//                    } else {
//                        [NSObject showHudTipStr:@"删除失败"];
//                    }
//                } failure:^(NSError *error) {
//                    
//                }];
//            }];
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            [alertController addAction:comfirm];
//            [alertController addAction:cancel];
//            [self presentViewController:alertController animated:YES completion:nil];
//        } else {
//            WWAddFriendViewController *addFriendVC = [[WWAddFriendViewController alloc] init];
//            addFriendVC.friendId = self.user.id;
//            [self.navigationController pushViewController:addFriendVC animated:YES];
//        }
//    }
//}
//
//- (IBAction)sendMessage {
//    if (!self.user) {
//        WWAccountViewController *account = [[WWAccountViewController alloc] init];
//        [self.navigationController pushViewController:account animated:YES];
//    } else {
//        WWChatViewController *chatVC = [[WWChatViewController alloc] init];
//        chatVC.conversationType = ConversationType_PRIVATE;
//        chatVC.targetId = self.user.id;
//        [self.navigationController pushViewController:chatVC animated:YES];
//    }
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    WWStoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"WWStoryListCell" owner:nil options:nil].firstObject;
//    }
//    if (indexPath.row % 2 == 0) {
//        cell.type = @"1";
//    } else if (indexPath.row % 3 == 0) {
//        cell.type = @"2";
//    } else {
//        cell.type = @"0";
//    }
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        WWPhotoCommentViewController *photoCommentVC = [[WWPhotoCommentViewController alloc] init];
//        [self.navigationController pushViewController:photoCommentVC animated:YES];
//    }else {
//        WWVideoCommentViewController *videoCommentVC = [[WWVideoCommentViewController alloc] init];
//        [self.navigationController pushViewController:videoCommentVC animated:YES];
//    }
//}
//@end
//#import "WWSelectTagViewController.h"
//@interface WWSelectTagViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
//    NSUInteger _currentPage;
//    UILabel *_titleLabel;
//    NSMutableString *_selectString;
//}
//@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic,strong)NSMutableArray * dataArr;
//@property (nonatomic, strong) NSMutableArray *selectDataArr;
//@end
//@implementation WWSelectTagViewController
//static NSString * const reuseIdentifier = @"Cell";
//#pragma mark- 懒加载
//-(NSMutableArray *)dataArr
//{
//    if(!_dataArr){
//        _dataArr=[[NSMutableArray alloc] init];
//    }
//    return _dataArr;
//}
//
//- (NSMutableArray *)selectDataArr {
//    if (!_selectDataArr) {
//        _selectDataArr = [[NSMutableArray alloc] init];
//    }
//    return _selectDataArr;
//    
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
//    _titleLabel.textColor = [UIColor redColor];
//    self.navigationItem.titleView = _titleLabel;
//    UIBarButtonItem *barbuttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hangyefenlei_gengduo"] style:UIBarButtonItemStylePlain target:self action:@selector(wrap)];
//    barbuttonItem.tintColor = [UIColor redColor];
//    self.navigationItem.leftBarButtonItem = barbuttonItem;
//    
//    WWSelectTagFlowLayout *flowLayout = [[WWSelectTagFlowLayout alloc] init];
//    self.view.backgroundColor = [UIColor redColor];
//    
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 44) collectionViewLayout:flowLayout];
//    self.collectionView.backgroundColor = [UIColor whiteColor];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
//    self.collectionView.scrollEnabled = NO;
//    self.collectionView.dataSource = self;
//    self.collectionView.delegate = self;
//    self.collectionView.allowsMultipleSelection = YES;
//    [self.view addSubview:self.collectionView];
//    [self configBottomButton];
//    [self request];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//}
//- (void)request {
//    [DDNetworkHelper POST:@"user/findUserOneLable" parameters:@{@"pageNum":@(_currentPage),@"pageSize":@9} success:^(id responseObject) {
//        self.dataArr = [NSArray modelArrayWithClass:[WWInterestTagModel class] json:responseObject[@"data"][@"list"]].mutableCopy;
//        [self.collectionView reloadData];
//        _currentPage ++;
//    } failure:^(NSError *error) {
//    }];
//}
//
//- (void)wrap {
//    WWSelectTagDetailViewController *selectTagDetailVC = [[WWSelectTagDetailViewController alloc] init];
//    selectTagDetailVC.selectTags = self.selectDataArr;
//    selectTagDetailVC.FinishBlock = ^(NSString *selectTags) {
//        _titleLabel.text = selectTags;
//    };
//    [self.navigationController pushViewController:selectTagDetailVC animated:YES];
//}
//
//- (void)configBottomButton {
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), SCREEN_WIDTH, 44)];
//    footerView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:footerView];
//    UIButton *leftButton = [self confiButtonWithTitle:@"换一批" center:CGPointMake(60, 22)];
//    UIButton *rightButton = [self confiButtonWithTitle:@"完成"  center:CGPointMake(self.view.width - 60, 22)];
//    [footerView addSubview:leftButton];
//    [footerView addSubview:rightButton];
//}
//- (UIButton *)confiButtonWithTitle:(NSString *)title center:(CGPoint)center {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.bounds = CGRectMake(0, 0, 100, 44);
//    button.center = center;
//    [button setTitle:title forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}
//- (void)buttonClick:(UIButton *)button {
//    if ([button.currentTitle isEqualToString:@"完成"]) {
//        [self registerSuccess];
//    } else {
//        [self request];
//    }
//}
//- (void)registerSuccess {
//    
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setDictionary:self.dataDic];
//    [parameters setValue:@"2" forKey:@"dev"];
//    [parameters setValue:_selectString forKey:@"lable"];
//    [DDNetworkHelper POST:kRegister parameters:parameters success:^(id responseObject) {
//        if ([responseObject[@"code"] integerValue] == 1) {
//            [NSObject showHudTipStr:@"注册成功"];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        } else {
//            [NSObject showHudTipStr:responseObject[@"message"]];
//        }
//    } failure:^(NSError *error) {
//    }];
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.dataArr.count;
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    WWInterestTagModel *model = self.dataArr[indexPath.item];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.userLableHeadurl] placeholderImage:PLCAEHOLDERIMAGE];
//    cell.tagNameLabel.text = model.userLableName;
//    return cell;
//}
//
//- (BOOL)collectionView: (UICollectionView *)collectionView
//shouldHighlightItemAtIndexPath: (NSIndexPath *)indexPath{
//    return YES;
//}
//- (void)collectionView: (UICollectionView *)collectionView
//didHighlightItemAtIndexPath: (NSIndexPath *)indexPath{
//    
//    [self changeHighlightCellWithIndexPath:indexPath];
//}
//- (void)collectionView: (UICollectionView *)collectionView
//didUnhighlightItemAtIndexPath: (NSIndexPath *)indexPath{
//    
//    [self changeHighlightCellWithIndexPath:indexPath];
//    
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    PhotoCell *cell = (PhotoCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//    [self changeSelectStateWithCell:cell];
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    PhotoCell *cell = (PhotoCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//    [self changeSelectStateWithCell:cell];
//}
//
///**
// * Cell根据Cell选中状态来改变Cell上Button按钮的状态
// */
//- (void) changeSelectStateWithCell: (PhotoCell *) currentSelecteCell{
//    NSIndexPath *indexPath = [self.collectionView indexPathForCell:currentSelecteCell];
//    if ([self.selectDataArr containsObject:self.dataArr[indexPath.item]]) {
//        return;
//    }
//    [self.selectDataArr addObject:self.dataArr[indexPath.item]];
//    NSMutableString *muString = [NSMutableString string];
//    _selectString = [NSMutableString string];
//    for (WWInterestTagModel *model in self.selectDataArr) {
//        [muString appendFormat:@"%@",[NSString stringWithFormat:@"#%@",model.userLableName]];
//        [_selectString appendFormat:@"%@",[NSString stringWithFormat:@"%@,",model.userLableName]];
//    }
//    NSRange range = NSMakeRange(_selectString.length - 1, 1);
//    [_selectString deleteCharactersInRange:range];
//    _titleLabel.text = muString;
//}
//@end
//#import "LoginViewController.h"
//@interface LoginViewController () <UINavigationControllerDelegate> {
//    BOOL _phoneNumberValid;
//    RACSignal *_loginSignal;
//}
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageViewHeightConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottomSpace;
//@end
//@implementation LoginViewController
//- (IBAction)prptocolPrss:(UIButton *)sender {
//    WWBaseWebViewController *web = [[WWBaseWebViewController alloc] init];
//    [self presentViewController:web animated:NO completion:nil];
//}
//
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//    if (operation == UINavigationControllerOperationPush) {
//        return [[WWCustomTransition alloc] initWithType:XWPresentOneTransitionTypePush];
//    } else if(operation == UINavigationControllerOperationPop) {
//        return [[WWCustomTransition alloc] initWithType:XWPresentOneTransitionTypePop];
//    }
//    return nil;
//    
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    if (kiPhone4 || [[WWGlobalSet globalSet] currentDeviceTypeIsIpad]) {
//        self.topConstraint.constant = 80;
//        self.ImageViewHeightConstraint.constant = 80;
//        self.imageBottomSpace.constant = 30;
//    }
//    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UIImageView *subImageView = [[UIImageView alloc] initWithFrame:appdelegate.drawView.bounds];
//    subImageView.image = [UIImage imageNamed:@"img_background_2"];
//    [appdelegate.drawView addSubview:subImageView];
//    self.navigationController.delegate = self;
//    self.phoneNumberView.backgroundColor = [UIColor clearColor];
//    self.passwordView.backgroundColor = [UIColor clearColor];
//    self.sureLogin.clipsToBounds = YES;
//    self.sureLogin.layer.cornerRadius = 5;
//    self.phoneNumberView.layer.cornerRadius = 5;
//    self.phoneNumberView.clipsToBounds = YES;
//    self.phoneNumberView.layer.masksToBounds = YES;
//    self.phoneNumberView.layer.borderWidth = 1.0f;
//    self.phoneNumberView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.passwordView.layer.cornerRadius = 5;
//    self.passwordView.clipsToBounds = YES;
//    self.passwordView.layer.masksToBounds = YES;
//    self.passwordView.layer.borderWidth = 1.0f;
//    self.passwordView.layer.borderColor = [UIColor whiteColor].CGColor;
//    CGRect rect_screen = [[UIScreen mainScreen]bounds];
//    CGSize size_screen = rect_screen.size;
//    CGFloat scale_screen = [UIScreen mainScreen].scale;
//    CGFloat width = size_screen.width*scale_screen;
//    CGFloat height = size_screen.height*scale_screen;
//    self.logoHeigt.constant = height*200/1334/2;
//    self.phoneTextField.text = @"";
//    self.passwordField.text = @"";
//    self.phoneTextField.borderStyle = UITextBorderStyleNone;
//    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
//    self.passwordField.borderStyle = UITextBorderStyleNone;
//    
//    self.phoneTextField.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FFFFFF"], NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
//    self.passwordField.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FFFFFF"], NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
//    self.passwordField.secureTextEntry = YES;
//    if (kDeviceIs5S) {
//        self.topHeight.constant = 30;
//    }
//    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"登录或注册代表你同意《用户注册协议》"];
//    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, 10)];
//    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(10, 8)];
//    [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F4F4F4"] range:NSMakeRange(0, 10)];
//    [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FC686B"] range:NSMakeRange(10, 8)];
//    [_protocolBt setAttributedTitle:title forState:UIControlStateNormal];
//    
//    RACSignal *phoneTextFieldSignal = [self.phoneTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//        return @([self validphoneNumber:value]);
//    }];
//    RACSignal *passwordSignal = [self.passwordField.rac_textSignal map:^id _Nullable(NSString * _Nullable password) {
//        return @([self validPassword:password]);
//    }];
//    
//    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[phoneTextFieldSignal,passwordSignal] reduce:^id (NSNumber *phoneValid, NSNumber *passwordValid){
//        return @([phoneValid boolValue] && [passwordValid boolValue]);
//    }];
//    [signUpActiveSignal subscribeNext:^(NSNumber * _Nullable x) {
//        self.sureLogin.enabled = [x boolValue];
//    }];
//    RACSignal *testSignal = [[[self.sureLogin rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
//        return [self signUpSignal];
//    }] doNext:^(id  _Nullable x) {
//        self.sureLogin.enabled = NO;
//    }];
//    _loginSignal = testSignal;
//    
//    [_loginSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"Sign in result --%@",x);
//        [NSObject showHudTipStr:x];
//        self.sureLogin.enabled = YES;
//    } error:^(NSError * _Nullable error) {
//        [NSObject showHudTipStr:@"登录失败"];
//        self.sureLogin.enabled = YES;
//    } completed:^{
//        [NSObject showHudTipStr:@"登录成功"];
//        self.sureLogin.enabled = YES;
//    }];
//}
//
//- (BOOL)validphoneNumber:(NSString *)phoneNumber {
//    return phoneNumber.length == 11 ? YES : NO;
//}
//
//- (BOOL)validPassword:(NSString *)password {
//    return password.length >= 6 ? YES : NO;
//}
//
//- (RACSignal *)signUpSignal {
//    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//        [parameters setValue:self.passwordField.text forKey:@"pwd"];
//        [parameters setValue:@"2" forKey:@"dev"];
//        NSString *path = [NSString stringWithFormat:@"%@%@",kLogin,self.phoneTextField.text];
//        [DDNetworkHelper POST:path parameters:parameters success:^(id responseObject) {
//            NSLog(@"%@",responseObject);
//            if ([responseObject[@"code"] integerValue] == 1) {
//                [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"userToken"] forKey:@"userToken"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                //归档
//                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//                [userInfo setDictionary:responseObject[@"data"][@"userInfo"]];
//                [userInfo setObject:responseObject[@"data"][@"rongYunToken"] forKey:@"rongYunToken"];
//                [subscriber sendNext:responseObject[@"正在配置用户信息"]];
//                [WWAccountManager AccountInfoWithDict:userInfo];
//                //                [self loginRongCloudWithToken:[WWAccountManager getAccount].rongYunToken];
//                [[RCIM sharedRCIM] connectWithToken:[WWAccountManager getAccount].rongYunToken success:^(NSString *userId) {
//                    dispatch_sync_on_main_queue(^{
//                        [subscriber sendNext:responseObject[@"正在登录..."]];
//                        [subscriber sendCompleted];
//                        WWHomeIndexViewController *homeIndexViewController = [[WWHomeIndexViewController alloc] init];
//                        WWBaseNavViewController *baseNav = [[WWBaseNavViewController alloc] initWithRootViewController:homeIndexViewController];
//                        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                        delegate.window.rootViewController = baseNav;
//                        [delegate.window makeKeyAndVisible];
//                        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                        [appdelegate.drawView removeAllSubviews];
//                    });
//                } error:^(RCConnectErrorCode status) {
//                } tokenIncorrect:^{
//                }];
//            }else {
//                [NSObject showHudTipStr:responseObject[@"message"]];
//            }
//        } failure:^(NSError *error) {
//        }];
//        return nil;
//    }];
//}
//
//- (IBAction)toRegisterAction:(id)sende {
//    RegisterViewController *rVc = [[RegisterViewController alloc] init];
//    
//    [self.navigationController pushViewController:rVc animated:YES];
//}
//- (IBAction)forgetPasswordAction:(id)sende {
//    ForgetPasswordController *forVc = [[ForgetPasswordController alloc]init];
//    [self.navigationController pushViewController:forVc animated:YES];
//}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
//- (IBAction)back:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//@end
