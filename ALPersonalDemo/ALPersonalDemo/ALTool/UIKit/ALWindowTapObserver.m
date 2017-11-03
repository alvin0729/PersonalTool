//
//  ALWindowTapObserver.m
//  ALPersonalDemo
//
//  Created by 懂懂科技 on 2017/11/1.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALWindowTapObserver.h"

@interface ALWindowTapObserver ()<UIGestureRecognizerDelegate>

/** TapGesture to resign keyboard on view's touch...... */
@property(nonatomic, strong) UITapGestureRecognizer  *tapGesture;

@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *touchResignedGestureIgnoreClasses;

@property(nonatomic, strong) UIView *observedView;

@property(nonatomic, copy) dispatch_block_t privateBlock;

@end


@implementation ALWindowTapObserver

+(void)load
{
    [self performSelectorOnMainThread:@selector(sharedManager) withObject:nil waitUntilDone:NO];
}

-(instancetype)init
{
    if (self = [super init])
    {
        __weak typeof(self) weakSelf = self;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
            strongSelf.tapGesture.cancelsTouchesInView = NO;
            [strongSelf.tapGesture setDelegate:self];
            strongSelf.touchResignedGestureIgnoreClasses = [[NSMutableSet alloc] initWithObjects:[UIControl class],[UINavigationBar class], nil];
        });
    }
    return self;
}


+ (ALWindowTapObserver*)sharedManager
{
    //Singleton instance
    static ALWindowTapObserver *tapManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tapManager = [[self alloc] init];
    });
    
    return tapManager;
}

-(void)addObserverTouchView:(UIView *)view withBlock:(nullable dispatch_block_t)block{
    if (nil == view) {
        return;
    }else{
        if (_observedView) {
            [_observedView.window removeGestureRecognizer:_tapGesture];
        }
        _observedView = view;
        [_observedView.window addGestureRecognizer:_tapGesture];
    }
    if (block) {
        self.privateBlock = block;
    }
}

- (void)tapRecognized:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        //Resigning currently responder.
        [self resignFirstResponder];
    }
}

- (BOOL)resignFirstResponder
{
    self.privateBlock();
    return YES;
}


/** Note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES. */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

/** To not detect touch events in a subclass of UIControl, these may have added their own selector for specific work */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //  Should not recognize gesture if the clicked view is either UIControl or UINavigationBar(<Back button etc...)
    for (Class aClass in self.touchResignedGestureIgnoreClasses)
    {
        if ([[touch view] isKindOfClass:aClass])
        {
            return NO;
        }
    }
    return YES;
}

@end
