/*
 * IFlyAIUIPcmRecorder.h
 * AIUIDemo
 *
 * Created on: 2018年4月14日
 *     Author: 讯飞AIUI开放平台（http://aiui.xfyun.cn）
 */

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioFile.h>
#import <AudioToolbox/AudioServices.h>
#import <AudioToolbox/AudioConverter.h>
#import <AVFoundation/AVFoundation.h>


@class IFlyAIUIPcmRecorder;

/*!
 *  录音协议
 */
@protocol IFlyAIUIPcmRecorderDelegate<NSObject>

/*!
 *  回调音频数据
 *
 *  @param buffer 音频数据
 *  @param size   表示音频的长度
 */
- (void) onIFlyAIUIRecorderBuffer: (const void *)buffer bufferSize:(int)size;

/*!
 *  回调音频的错误码
 *
 *  @param recoder 录音器
 *  @param error   错误码
 */
- (void) onIFlyAIUIRecorderError:(IFlyAIUIPcmRecorder*)recoder theError:(int) error;

@optional

/*!
 *  回调录音音量
 *
 *  @param power 音量值
 */
- (void) onIFlyAIUIRecorderVolumeChanged:(int) power;

@end


/*!
 *  录音器控件
 */
@interface IFlyAIUIPcmRecorder : NSObject<AVAudioSessionDelegate>

/*!
 *  录音委托对象
 */
@property (nonatomic,assign) id<IFlyAIUIPcmRecorderDelegate> delegate;

/*!
 *  用于设置是否在录音结束后发送Deactive通知，默认是YES：发送
 */
@property (nonatomic,assign) BOOL isNeedDeActive;

/*!
 *  单例模式
 *
 *  @return 返回录音对象单例
 */
+ (instancetype) sharedInstance;

/*!
 *  开始录音
 *
 *  @return  开启录音成功返回YES，否则返回NO
 */
- (BOOL) startRecord;

/*!
 *  停止录音
 */
- (void) stopRecord;

/*!
 *  设置音频采样率
 *
 *  @param rate -[in] 采样率，8k/16k
 */
- (void) setSample:(NSString *) rate;

/*!
 * 设置录音音量回调时间间隔参数
 */
- (void) setPowerCycle:(float) cycle;

/*!
 *  保存录音
 *
 *  @param savePath 音频保存路径
 */
-(void) setSaveAudioPath:(NSString *)savePath;

/*!
 *  录音器是否完成
 *
 *  @return  录音器完全结束返回YES，否则返回NO
 */
-(BOOL) isCompleted;

@end

