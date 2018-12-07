/*
 * IFlyAIUIPcmRecorder.m
 * AIUIDemo
 *
 * Created on: 2018年4月14日
 *     Author: 讯飞AIUI开放平台（http://aiui.xfyun.cn）
 */

//
//#import "IFlyAIUIPcmRecorder.h"
//#import <UIKit/UIKit.h>
//
//#define NUM_BUFFERS 10
//#define RECORD_CYCLE   0.003    //录音音量回调时间间隔
//
//typedef NS_ENUM(NSInteger,IFlyRECState) {
//    RECEnd          = 0x00,             //录音结束
//    RECIng          = 0x01,             //正在录音
//    RECPause        = 0x02,             //正在暂停
//    RECCancel       = 0x03,             //取消状态
//};
//
///**
// *  内部录音单元
// */
//typedef struct{
//    AudioFileID                 audioFile;
//    AudioStreamBasicDescription dataFormat;
//    AudioQueueRef               queue;
//    AudioQueueLevelMeterState    *audioLevels;
//    AudioQueueBufferRef         buffers[NUM_BUFFERS];
//    UInt32                      bufferByteSize;
//    SInt64                      currentPacket;
//    IFlyRECState                RECState;
//    IFlyAIUIPcmRecorder             *recorder;
//
//} IFlyRecordState;
//
//@interface IFlyAIUIPcmRecorder(){
//    IFlyRecordState state; //内部录音单元
//    BOOL            _isRegisterRunningCB;
//}
//
//@property(nonatomic,assign)Float64  mSampleRate;    //采样率
//@property(nonatomic,assign)UInt32   mBits;            //比特率
//@property(nonatomic,assign)UInt32   mChannels;        //声道数
//@property(nonatomic,retain)NSTimer* mGetPowerTimer; //音量获取时钟
//@property(nonatomic,assign)NSString* mSaveAudioPath; //保存文件路径
//@property(nonatomic,assign)FILE*    mSaveFile;       //保存文件句柄
//
//@property(nonatomic,assign)float    mPowerGetCycle;  //音量获取时间间隔
//
//
//- (void)setupAudioFormat:(AudioStreamBasicDescription*)format;
//
//void AIUIAQRecordRecordListenBack(void * inUserData,AudioQueueRef inAQ,AudioQueuePropertyID inID);
//void interruptionListener(void * inClientData, UInt32 inInterruptionState);
//void AIUIHandleInputBuffer (void *aqData,AudioQueueRef inAQ,AudioQueueBufferRef inBuffer,const AudioTimeStamp *inStartTime,UInt32 inNumPackets,const AudioStreamPacketDescription *inPacketDesc);
//void AIUIDeriveBufferSize (AudioQueueRef audioQueue,AudioStreamBasicDescription ASBDescription, Float64 seconds, UInt32 *outBufferSize);
//
//@end
//
//static IFlyAIUIPcmRecorder *iFlyPcmRecorder = nil;
//
//@implementation IFlyAIUIPcmRecorder
//
//@synthesize delegate = _delegate;
//@synthesize mSampleRate;
//@synthesize mBits;
//@synthesize mChannels;
//@synthesize mGetPowerTimer;
//@synthesize mSaveAudioPath;
//@synthesize mSaveFile;
//@synthesize mPowerGetCycle;
//
//#pragma mark - system
//- (instancetype) init{
//    if (self = [super init]) {
//        mSampleRate = 16000.0;
//        mBits = 16;
//        mChannels = 1;
//
//        state.RECState = RECEnd;
//        state.recorder = self;
//        [self setupAudioFormat : &state.dataFormat];
//        state.currentPacket = 0;
//
//        mSaveAudioPath = nil;
//        mSaveFile = NULL;
//        mPowerGetCycle = RECORD_CYCLE;
//
//        _isNeedDeActive = YES;
//        _isRegisterRunningCB = NO;
//    }
//    return self;
//}
//
//- (void) dealloc{
//    self.delegate = nil;
//    [self SetGetPowerTimerInvalidate];
//    if(mSaveAudioPath)
//    {
//        //[mSaveAudioPath release];
//        mSaveAudioPath = nil;
//    }
//
//    //[super dealloc];
//}
//
//+ (instancetype) sharedInstance{
//    if (iFlyPcmRecorder == nil) {
//        iFlyPcmRecorder = [[IFlyAIUIPcmRecorder alloc] init];
//    }
//    return iFlyPcmRecorder;
//}
//
//#pragma mark - system call back
//
//void AIUIAQRecordRecordListenBack(void * inUserData,AudioQueueRef inAQ,AudioQueuePropertyID inID){
//    IFlyRecordState *state = inUserData;
//    UInt32 running;
//    UInt32 size;
//    OSStatus err ;
//
//    NSLog(@"%s[IN],state=%d",__func__,state->RECState);
//
//    if (state->RECState == RECEnd){
//        return;
//    }
//
//    AudioQueueGetPropertySize(inAQ, kAudioQueueProperty_IsRunning, &size);
//    err = AudioQueueGetProperty(inAQ, kAudioQueueProperty_IsRunning, &running, &size);
//    if (err){
//
//        NSLog(@"get kAudioQueueProperty_IsRunning error:%d", err);
//        return;
//    }
//    if (!running){
//
//        NSLog(@"stop recording success");
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            [state->recorder setRecorderState:RECEnd];
//        });
//    }
//
//    NSLog(@"%s[OUT]",__func__);
//}
//
//
//void AIUIHandleInputBuffer (void *aqData,AudioQueueRef inAQ,AudioQueueBufferRef inBuffer,const AudioTimeStamp *inStartTime,UInt32 inNumPackets,const AudioStreamPacketDescription   *inPacketDesc){
//    IFlyRecordState *pAqData = (IFlyRecordState *) aqData;
//    IFlyAIUIPcmRecorder *recorder = pAqData->recorder;
//
//    //NSLog(@"%s[IN], state=%d", __func__, pAqData->RECState);
//
//    if(pAqData->RECState == RECEnd || pAqData->RECState == RECCancel){
//        return;
//    }
//
//    //音量回调放在第一块音频输出时才调用，避免外部说话时机先于录音启动
//    if(!recorder->mGetPowerTimer && recorder->_delegate){
//        recorder->mGetPowerTimer = [NSTimer timerWithTimeInterval:recorder->mPowerGetCycle target:recorder selector:@selector(getPower) userInfo:nil repeats:YES];//RECORD_CYCLE
//
//        //jmli3 20180111:必须在主线程的runloop运行音量定时器，否则会影响后台进入前台时，音量回调里的界面更新
//        [[NSRunLoop mainRunLoop] addTimer:recorder->mGetPowerTimer forMode:NSRunLoopCommonModes];
//
//        [recorder->mGetPowerTimer fire];
//    }
//
//    if (inNumPackets == 0 && pAqData->dataFormat.mBytesPerPacket != 0){
//        inNumPackets = inBuffer->mAudioDataByteSize / pAqData->dataFormat.mBytesPerPacket;
//    }
//
//    if (recorder.delegate && pAqData->RECState != RECEnd && pAqData->RECState != RECCancel){
//        //保存文件
//        if(recorder->mSaveFile != NULL){
//            fseek(recorder->mSaveFile, 0, SEEK_END);
//            fwrite(inBuffer->mAudioData, inBuffer->mAudioDataByteSize, 1, recorder->mSaveFile);
//        }
//
//        [recorder.delegate onIFlyAIUIRecorderBuffer:inBuffer->mAudioData bufferSize:inBuffer->mAudioDataByteSize];
//    }
//
//    pAqData->currentPacket += inNumPackets;
//
//    if (pAqData->RECState == RECIng){
//        AudioQueueEnqueueBuffer (pAqData->queue,inBuffer,0,NULL);
//    }
//}
//
//void AIUIDeriveBufferSize (AudioQueueRef audioQueue,AudioStreamBasicDescription ASBDescription,Float64 seconds,UInt32 *outBufferSize){
//    static const int maxBufferSize = 0x50000;
//    int maxPacketSize = ASBDescription.mBytesPerPacket;
//    if (maxPacketSize == 0){
//        UInt32 maxVBRPacketSize = sizeof(maxPacketSize);
//        AudioQueueGetProperty (audioQueue,kAudioConverterPropertyMaximumOutputPacketSize,&maxPacketSize,&maxVBRPacketSize);
//    }
//
//    Float64 numBytesForTime =ASBDescription.mSampleRate * maxPacketSize * seconds;
//    *outBufferSize =  (UInt32) ((numBytesForTime < maxBufferSize) ? numBytesForTime : maxBufferSize);                     // 9
//}
//
//
//#pragma mark - funcs
//
///**
// *  开始录音
// *  在开始录音前可以调用IFlyAudioSession +(BOOL) initRecordingAudioSession; 方法初始化音频队列
// *
// *  @return  开启录音成功返回YES，否则返回NO
// */
//- (BOOL) startRecord{
//
//    @synchronized(self) {
//        NSLog(@"%s,[IN]",__func__);
//
//        if(state.RECState != RECEnd){
//            NSLog(@"%s,[OUT],_state=%d",__func__,state.RECState);
//            return NO;
//        }
//
//        if(state.queue != NULL){
//            if(_isRegisterRunningCB){
//                AudioQueueRemovePropertyListener(state.queue, kAudioQueueProperty_IsRunning, AIUIAQRecordRecordListenBack, &state);
//                _isRegisterRunningCB = NO;
//            }
//
//            OSStatus error;
//            error = AudioQueueDispose(state.queue, true);
//            if (error){
//                NSLog(@"%s|AudioQueueDispose error:%d", __func__, error);
//            }
//            NSLog(@"%s|AudioQueueDispose", __func__);
//
//            state.queue = NULL;
//        }
//
//        OSStatus error = 0;
//        NSError *avError;
//
//        if(![self canRecord]){
//            NSLog(@"%s System Recorder no permission",__func__);
//            return NO;
//        }
//
//        BOOL success = [[AVAudioSession sharedInstance] setActive:YES error:&avError];
//        if (!success){
//            NSLog(@"%s| avSession setActive YES error:@%",__func__,avError);
//        }
//
//        error= AudioQueueNewInput(&state.dataFormat,AIUIHandleInputBuffer,&state,NULL,NULL,0,&state.queue);
//        if (error){
//            NSLog(@"%s|AudioQueueNewInput error:%d",__func__,error);
//            //终止获取录音音量timer
//            [self SetGetPowerTimerInvalidate];
//            return NO;
//        }
//
//        AIUIDeriveBufferSize(state.queue, state.dataFormat, 0.15, &state.bufferByteSize);
//
//        for(int i = 0; i < NUM_BUFFERS; i++){
//            error = AudioQueueAllocateBuffer(state.queue,state.bufferByteSize,&state.buffers[i]);
//            if (error){
//                NSLog(@"%s|AudioQueueAllocateBuffer error:%d",__func__,error);
//                [self SetGetPowerTimerInvalidate];
//                return NO;
//            }
//
//            error = AudioQueueEnqueueBuffer(state.queue, state.buffers[i], 0, NULL);
//            if (error){
//                NSLog(@"%s|AudioQueueEnqueueBuffer error:%d",__func__,error);
//                [self SetGetPowerTimerInvalidate];
//                return NO;
//            }
//        }
//
//        error = AudioQueueAddPropertyListener(state.queue, kAudioQueueProperty_IsRunning, AIUIAQRecordRecordListenBack, &state);
//        if (error){
//            NSLog(@"%s| AudioQueueAddPropertyListener error:%d",__func__,error);
//            [self SetGetPowerTimerInvalidate];
//            return NO;
//        }
//
//        _isRegisterRunningCB = YES;
//
//        error = AudioQueueStart(state.queue, NULL);
//        if (error != 0) {
//            NSLog(@"%s|AudioQueueStart error:%d",__func__,error);
//            OSStatus err;
//            err = AudioQueueFlush(state.queue);
//            if (error){
//                NSLog(@"%s|AudioQueueFlush error:%d", __func__, err);
//            }
//            NSLog(@"%s|AudioQueueFlush", __func__);
////            AudioQueueStop(state.queue, true);
//            [self SetGetPowerTimerInvalidate];
//            return NO;
//        }
//
//        [self setRecorderState:RECIng];
//
//        // allocate the memory needed to store audio level information
//        state.audioLevels = (AudioQueueLevelMeterState *) calloc (sizeof (AudioQueueLevelMeterState), mChannels);
//        UInt32 trueValue = true;
//        AudioQueueSetProperty (state.queue,kAudioQueueProperty_EnableLevelMetering,&trueValue,sizeof (UInt32));
//        state.currentPacket = 0;
//
//        if ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending){
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruption:) name:AVAudioSessionInterruptionNotification object:nil];
//        }
//        else{
//            [[AVAudioSession sharedInstance] setDelegate:self];
//        }
//
//        //打开文件
//        if(mSaveFile == NULL){
//            //删除之前文件
//            mSaveFile = fopen([mSaveAudioPath UTF8String], "rb");
//            if(mSaveFile){
//                fclose(mSaveFile);
//                mSaveFile = nil;
//                remove([mSaveAudioPath UTF8String]);
//            }
//            mSaveFile = fopen([mSaveAudioPath UTF8String], "wb+");
//        }
//
//        NSLog(@"%s,[OUT],ret =%d",__func__,error);
//
//        return YES;
//    }
//}
//
//- (void) stopRecord{
//
//    @synchronized(self) {
//
//        NSLog(@"%s[IN],state=%d",__func__,state.RECState);
//
//        //xlhou add
//        if(!state.queue){
//            return;
//        }
//
//        if (state.RECState == RECEnd || state.RECState == RECCancel){
//            return;
//        }
//
//        [self setRecorderState:RECCancel];
//
//        //终止获取录音音量timer
//        [self SetGetPowerTimerInvalidate];
//
//        if(self.mSaveFile){
//            fclose(self.mSaveFile);
//            self.mSaveFile = NULL;
//        }
//
//        if(state.audioLevels){
//            free(state.audioLevels);
//            state.audioLevels = NULL;
//        }
//
//        self.delegate = nil;
//
//        OSStatus error;
//        error = AudioQueueFlush(state.queue);
//        if (error){
//            NSLog(@"%s|AudioQueueFlush error:%d", __func__, error);
//        }
//        NSLog(@"%s|AudioQueueFlush", __func__);
//
//        OSStatus err;
//        err = AudioQueueStop(state.queue, true);
//        if (error){
//            NSLog(@"%s|AudioQueueStop error:%d", __func__, err);
//        }
//
//        NSLog(@"%s|AudioQueueStop", __func__);
//
//        NSLog(@"%s[OUT]",__func__);
//    }
//}
//
//
///*
// * 设置sample参数
// */
//- (void) setSample:(NSString *) rate{
//    NSLog(@"%s,rate=%@",__func__,rate);
//     mSampleRate=[rate floatValue];
//    [self setupAudioFormat : &state.dataFormat];
//}
//
///*
// * 设置录音时间间隔参数
// */
//- (void) setPowerCycle:(float) cycle{
//
//    NSLog(@"%s",__func__);
//
//    mPowerGetCycle = cycle;
//}
//
//
///*
// * 设置保存路径
// */
//-(void) setSaveAudioPath:(NSString *)savePath{
//    if(mSaveAudioPath)
//    {
//        //[mSaveAudioPath release];
//        mSaveAudioPath = nil;
//    }
//
//    if(savePath.length > 0)
//    {
//        mSaveAudioPath = [[NSString alloc] initWithFormat:@"%@",savePath];
//    }
//}
//
//-(BOOL) isCompleted{
//    if(state.RECState == RECEnd){
//        return YES;
//    }else{
//        return NO;
//    }
//}
//
//#pragma mark - private
//
//- (void) freeRecorderRes{
//
//    if(state.queue != NULL){
//        if(_isRegisterRunningCB){
//            AudioQueueRemovePropertyListener(state.queue, kAudioQueueProperty_IsRunning, AIUIAQRecordRecordListenBack, &state);
//            _isRegisterRunningCB = NO;
//        }
//
//        OSStatus error;
//        error = AudioQueueDispose(state.queue, true);
//        if (error){
//
//            NSLog(@"%s|AudioQueueDispose error", __func__);
//        }
//
//        NSLog(@"%s|AudioQueueDispose", __func__);
//
//        state.queue = NULL;
//    }
//
//    if ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending){
//        [[NSNotificationCenter defaultCenter]removeObserver:state.recorder  name:AVAudioSessionInterruptionNotification object:nil];
//    }
//    else{
//        if ([[AVAudioSession sharedInstance] delegate]== state.recorder){
//            [[AVAudioSession sharedInstance] setDelegate:nil];
//        }
//    }
//}
//
///*
// * @ 设置录音器的状态
// */
//- (void) setRecorderState:(IFlyRECState) recState
//{
//    @synchronized(self) {
//
//        if(state.RECState == recState){
//            return;
//        }
//        state.RECState = recState;
//
//        switch (recState)
//        {
//            case RECIng:
//                break;
//            case RECPause:
//                break;
//            case RECCancel:
//                break;
//            case RECEnd:
//            {
//
//                NSLog(@"%s,state=%d",__func__,RECEnd);
//
//                [self freeRecorderRes];
//
//                if(_isNeedDeActive){
//                    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:NULL];
//                }
//            }
//                break;
//            default:
//                break;
//        }
//    }
//}
//
//
//- (void)SetGetPowerTimerInvalidate{
//    if(mGetPowerTimer){
//        [mGetPowerTimer invalidate];
//        mGetPowerTimer=nil;
//    }
//}
//
//- (BOOL)canRecord{
//    __block BOOL bCanRecord = YES;
//
//    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending){
//        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//
//        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]){
//            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted){
//                if (granted) {
//                    bCanRecord = YES;
//                } else {
//                    bCanRecord = NO;
//                }
//            }];
//        }
//    }
//
//    return bCanRecord;
//}
//
//- (void)setupAudioFormat:(AudioStreamBasicDescription*)format{
//    format->mSampleRate = mSampleRate;
//    format->mFormatID = kAudioFormatLinearPCM;
//    format->mFormatFlags = kLinearPCMFormatFlagIsSignedInteger| kLinearPCMFormatFlagIsPacked;
//
//    format->mChannelsPerFrame = mChannels;
//    format->mBitsPerChannel = mBits;
//    format->mFramesPerPacket = 1;
//    format->mBytesPerPacket = 2;
//
//    format->mBytesPerFrame = 2;        // not used, apparently required
//    format->mReserved = 0;
//}
//
///*
// 获取音量
// */
//-(void) getPower{
//
//    @synchronized(self) {
//
//        if(state.RECState == RECIng){
//            UInt32 propertySize = mChannels * sizeof (AudioQueueLevelMeterState);
//            OSStatus error=AudioQueueGetProperty (state.queue,(AudioQueuePropertyID) kAudioQueueProperty_CurrentLevelMeter,state.audioLevels,&propertySize);
//            if(error){
//
//                NSLog(@"%s|getPower error", __func__);
//                return;
//            }
//
//            if (_delegate && [_delegate respondsToSelector:@selector(onIFlyRecorderVolumeChanged:)]){
//                //录音开始，并来电时，state.audioLevels有可能为空
//                if(state.audioLevels){
//                    int volume = state.audioLevels[0].mPeakPower *30;
//                    //volume超过30时，按照30处理，注意volume处理后的值是可能大于30的，并不需要按照其最大值来30等分，因为人的录音音量的跨度没有机器允许的值这么大。总之处理不当会引起录音的波形不明显。
//                    if(volume> 30){
//                        volume = 30;
//                    }
//
//                    //[_delegate onIFlyRecorderVolumeChanged:volume];
//                }
//            }
//        }
//    }
//}
//
//-(void)beginInterruption{
//    @synchronized(self) {
//
//        NSLog(@"%s,_state=%d",__func__,state.RECState);
//
//        if(state.RECState == RECEnd || state.RECState == RECCancel){
//            return;
//        }
//
//        if(state.RECState != RECPause){
//
//            [self SetGetPowerTimerInvalidate];
//
//            OSStatus error ;
//            error = AudioQueuePause(state.queue);
//            if (error){
//                NSLog(@"puase Recorder error:%d",error);
//            }
//            [self setRecorderState:RECPause];
//        }
//    }
//}
//
//-(void)endInterruption{
//    @synchronized(self) {
//
//        NSLog(@"%s,_state=%d",__func__,state.RECState);
//
//        if(state.RECState == RECEnd || state.RECState == RECCancel){
//            return;
//        }
//
//        if(state.RECState == RECPause){
//
//            [self setRecorderState:RECIng];
//
//            OSStatus error = AudioQueueStart(state.queue, NULL);
//            if (error){
//
//                NSLog(@"resume Recorder error:%d",error);
//
//                OSStatus err;
//                err = AudioQueueFlush(state.queue);
//                if (error){
//
//                    NSLog(@"%s|AudioQueueFlush error:%d", __func__, err);
//                }
//                NSLog(@"%s|AudioQueueFlush", __func__);
//
//                [self setRecorderState:RECEnd];
//            }else{
//                mGetPowerTimer = [NSTimer scheduledTimerWithTimeInterval:mPowerGetCycle target:self selector:@selector(getPower) userInfo:nil repeats:YES];
//                [[NSRunLoop currentRunLoop] addTimer:mGetPowerTimer forMode:NSRunLoopCommonModes];
//                [mGetPowerTimer fire];
//            }
//        }
//    }
//}
//
////Interruption handler
//-(void) interruption:(NSNotification*) aNotification{
//    NSDictionary *interuptionDict = aNotification.userInfo;
//    NSNumber* interuptionType = (NSNumber*)[interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey];
//    if([interuptionType intValue] == AVAudioSessionInterruptionTypeBegan){
//        [self beginInterruption];
//    }
//    else if ([interuptionType intValue] == AVAudioSessionInterruptionTypeEnded){
//        [self endInterruption];
//    }
//}
//
//
//@end
