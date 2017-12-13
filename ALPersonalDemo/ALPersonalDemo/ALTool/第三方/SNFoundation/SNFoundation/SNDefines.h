//
//  SNDefines.h
//  SNFoundation
//
//  Created by liukun on 14-3-2.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#ifndef SNFoundation_SNDefines_h
#define SNFoundation_SNDefines_h

/**
 * SN_EXTERN user this as extern
 */
#if !defined(SN_EXTERN)
#  if defined(__cplusplus)
#   define SN_EXTERN extern "C"
#  else
#   define SN_EXTERN extern
#  endif
#endif

/**
 * SN_INLINE user this as static inline
 */
#if !defined(SN_INLINE)
# if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
#  define SN_INLINE static inline
# elif defined(__cplusplus)
#  define SN_INLINE static inline
# elif defined(__GNUC__)
#  define SN_INLINE static __inline__
# else
#  define SN_INLINE static
# endif
#endif


#if !__has_feature(objc_arc)

/*safe release*/
#undef TT_RELEASE_SAFELY
#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
CFRelease(__REF); \
__REF = nil;\
}\
}

//view安全释放
#undef TTVIEW_RELEASE_SAFELY
#define TTVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
CFRelease(__REF);\
__REF = nil;\
}\
}

//释放定时器
#undef TT_INVALIDATE_TIMER
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
[__TIMER release];\
__TIMER = nil;\
}

#else

/*safe release*/
#undef TT_RELEASE_SAFELY
#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
__REF = nil;\
}\
}

//view安全释放
#define TTVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
__REF = nil;\
}\
}

//释放定时器
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}

#endif

//国际化
#undef L
#define L(key) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

//arc 支持performSelector:
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

// Debug logging
#if DEBUG
#define ICTextViewLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ICTextViewLog(...)
#endif

#define BAKit_Objc_setObj(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define BAKit_Objc_setObjCOPY(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY)

#define BAKit_Objc_getObj objc_getAssociatedObject(self, _cmd)

#define BAKit_Objc_exchangeMethodAToB(methodA,methodB) method_exchangeImplementations(class_getInstanceMethod([self class], methodA),class_getInstanceMethod([self class], methodB));

#pragma mark - NotiCenter
#define BAKit_NotiCenter [NSNotificationCenter defaultCenter]

/*!
 *  获取屏幕宽度和高度
 */
#define BAKit_SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define BAKit_SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#pragma mark - weak / strong
#define BAKit_WeakSelf        @BAKit_Weakify(self);
#define BAKit_StrongSelf      @BAKit_Strongify(self);

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@BAKit_Weakify`实现弱引用转换，`@BAKit_Strongify`实现强引用转换
 *
 * 示例：
 * @BAKit_Weakify
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef BAKit_Weakify
#if DEBUG
#if __has_feature(objc_arc)
#define BAKit_Weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define BAKit_Weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define BAKit_Weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define BAKit_Weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@BAKit_Weakify(object)`实现弱引用转换，`@BAKit_Strongify(object)`实现强引用转换
 *
 * 示例：
 * @BAKit_Weakify(object)
 * [obj block:^{
 * @BAKit_Strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef BAKit_Strongify
#if DEBUG
#if __has_feature(objc_arc)
#define BAKit_Strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define BAKit_Strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define BAKit_Strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define BAKit_Strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#endif
