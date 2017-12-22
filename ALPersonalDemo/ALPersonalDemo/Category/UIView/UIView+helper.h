

#import <UIKit/UIKit.h>

typedef void (^TapGestureBlock)(UIView *targetView);

typedef NS_ENUM(NSUInteger, HardwareScreenType) {
    HardwareScreenType35,
    HardwareScreenType4,
    HardwareScreenType47,
    HardwareScreenType55,
    HardwareScreenTypeMax
};

@interface UIView (helper)
+ (id)instanceWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner;
- (void)loadContentsWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil;

//hierarchy

- (UIView *)viewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)viewWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (UIView *)viewOfClass:(Class)viewClass;
- (NSArray *)viewsMatchingPredicate:(NSPredicate *)predicate;
- (NSArray *)viewsWithTag:(NSInteger)tag;
- (NSArray *)viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (NSArray *)viewsOfClass:(Class)viewClass;

- (UIView *)firstSuperviewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)firstSuperviewOfClass:(Class)viewClass;
- (UIView *)firstSuperviewWithTag:(NSInteger)tag;
- (UIView *)firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass;

- (BOOL)viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate;
- (BOOL)viewOrAnySuperviewIsKindOfClass:(Class)viewClass;
- (BOOL)isSuperviewOfView:(UIView *)view;
- (BOOL)isSubviewOfView:(UIView *)view;

- (UIViewController *)firstViewController;
- (UIView *)firstResponder;
- (void)removeAllSubViews;
+ (UIWindow *)rootWindow;
//frame accessors

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

// center
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//bounds accessors

@property (nonatomic, assign) CGSize boundsSize;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;

//content getters

@property (nonatomic, readonly) CGRect contentBounds;
@property (nonatomic, readonly) CGPoint contentCenter;

//additional frame setters

- (void)setLeft:(CGFloat)left right:(CGFloat)right;
- (void)setWidth:(CGFloat)width right:(CGFloat)right;
- (void)setTop:(CGFloat)top bottom:(CGFloat)bottom;
- (void)setHeight:(CGFloat)height bottom:(CGFloat)bottom;
- (void)setCenterWithHeight:(CGFloat)height;

//animation

- (void)crossfadeWithDuration:(NSTimeInterval)duration;
- (void)crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion;


#define SHOW_VIEW @"show"
#define HIDDEN_VIEW @"hidden"
+(void)MoveView:(UIView *)view To:(CGRect)frame During:(float)time;
+(void)ShowView:(UIView *)view To:(CGRect)frame During:(float)time delegate:(id)delegate;
+(void)HiddenView:(UIView *)view To:(CGRect)frame During:(float)time delegate:(id)delegate;

//依据控件调整
- (void)adjustFrameHeightHasStateBar:(BOOL)hasStateBar
                  hasNavigationBar:(BOOL)hasNavigationBar
                         hasTabBar:(BOOL)hasTabBar;
//对底部有确定按钮的做调整
- (void)adjustFrameHeightHasStateBar:(BOOL)hasStateBar
                    hasNavigationBar:(BOOL)hasNavigationBar
                           hasTabBar:(BOOL)hasTabBar
                    bottomViewHeight:(NSUInteger)bottomViewHeight;

- (void)adjustFrameOrgPointToAdptIOS6;
- (void)setStatusBarHidden:(BOOL)isHidden;
//数字控件和字符串控件二者存一
//添加圆形数字控件
-(void)displayRoundNumberWithPoint:(CGPoint)ori number:(u_int8_t)number;
-(void)displayRoundNumberWithPoint:(CGPoint)ori;
-(void)displayRoundPoint;
-(void)displayRoundNumber:(u_int8_t)number;
-(void)displayRoundNumberWithWidth:(CGFloat)width number:(u_int8_t)number;
-(void)displayRoundString:(NSString*)string;
-(void)removeRoundNumber;
-(void)removeRoundPoint;
//添加椭圆形字符串控件
-(void)displayEllipticStringWithPoint:(CGPoint)ori string:(NSString*)string;
-(void)displayEllipticString:(NSString*)string;
-(void)displayellipticStringAfterTitle: (NSString *)string;
-(void)removeEllipticString;

// 添加手势

- (void)setTapGestureWithEvent:(TapGestureBlock) block;
@end

@interface UIView(LayerEffects)
- (void) setCornerRadius : (CGFloat) radius;
- (void) setBorder : (UIColor *) color width : (CGFloat) width;
- (void) setShadow : (UIColor *)color opacity:(CGFloat)opacity offset:(CGSize) offset blurRadius:(CGFloat)blurRadius;
@end

@interface UIView (TagExtensions)
- (UIAlertView *) alertViewWithTag: (NSInteger) aTag;
- (UIActionSheet *) actionSheetWithTag: (NSInteger) aTag;
- (UITableView *) tableViewWithTag: (NSInteger) aTag;
- (UITableViewCell *) tableViewCellWithTag: (NSInteger) aTag;
- (UIImageView *) imageViewWithTag: (NSInteger) aTag;
- (UIWebView *) webViewWithTag: (NSInteger) aTag;
- (UITextView *) textViewWithTag: (NSInteger) aTag;
- (UIScrollView *) scrollViewWithTag: (NSInteger) aTag;
- (UIPickerView *) pickerViewWithTag: (NSInteger) aTag;
- (UIDatePicker *) datePickerWithTag: (NSInteger) aTag;
- (UISegmentedControl *) segmentedControlWithTag: (NSInteger) aTag;
- (UILabel *) labelWithTag: (NSInteger) aTag;
- (UIButton *) buttonWithTag: (NSInteger) aTag;
- (UITextField *) textFieldWithTag: (NSInteger) aTag;
- (UISwitch *) switchWithTag: (NSInteger) aTag;
- (UISlider *) sliderWithTag: (NSInteger) aTag;
- (UIProgressView *) progressViewWithTag: (NSInteger) aTag;
- (UIActivityIndicatorView *) activityIndicatorViewWithTag: (NSInteger) aTag;
- (UIPageControl *) pageControlWithTag: (NSInteger) aTag;
- (UIWindow *) windowWithTag: (NSInteger) aTag;
- (UISearchBar *) searchBarWithTag: (NSInteger) aTag;
- (UINavigationBar *) navigationBarWithTag: (NSInteger) aTag;
- (UIToolbar *) toolbarWithTag: (NSInteger) aTag;
- (UITabBar *) tabBarWithTag: (NSInteger) aTag;
@end

@interface UIView (AutoAdjustment)
+ (CGRect)autosizeWithx:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;
+ (CGFloat)getAutoSizeScaleByScreenType:(HardwareScreenType)screenType;
+ (CGRect)autoFrame:(CGRect)frame;
+ (CGRect)autoFrame:(CGRect)frame byScreenType:(HardwareScreenType)screenType;
+ (CGFloat)autoWidth:(CGFloat)width byScreenType:(HardwareScreenType)screenType;

@end

@interface UIView (PrintHelper)

+ (void)printRect:(CGRect)rect withPreString:(NSString *)preStr;
+ (void)printSize:(CGSize)size withPreString:(NSString *)preStr;
+ (void)printPoint:(CGPoint)point withPreString:(NSString *)preStr;

@end

@interface UIView (customizeView)

+ (UIView *)createViewWithBackgroudImage:(UIImage *)image frame:(CGRect)frame tag:(NSInteger)tag;

@end
