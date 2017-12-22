

#import "UIView+helper.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

@implementation UIView (helper)

+ (id)instanceWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner
{
    //default values
    NSString *nibName = nibNameOrNil ?: NSStringFromClass(self);
    NSBundle *bundle = bundleOrNil ?: [NSBundle mainBundle];
    
    //cache nib to prevent unnecessary filesystem access
    static NSCache *nibCache = nil;
    if (nibCache == nil)
    {
        nibCache = [[NSCache alloc] init];
    }
    NSString *pathKey = [NSString stringWithFormat:@"%@.%@", bundle.bundleIdentifier, nibName];
    UINib *nib = [nibCache objectForKey:pathKey];
    if (nib == nil)
    {
        NSString *nibPath = [bundle pathForResource:nibName ofType:@"nib"];
        if (nibPath) nib = [UINib nibWithNibName:nibName bundle:bundle];
        [nibCache setObject:nib ?: [NSNull null] forKey:pathKey];
    }
    else if ([nib isKindOfClass:[NSNull class]])
    {
        nib = nil;
    }
    
    if (nib)
    {
        //attempt to load from nib
        NSArray *contents = [nib instantiateWithOwner:owner options:nil];
        UIView *view = [contents count]? [contents objectAtIndex:0]: nil;
        NSAssert ([view isKindOfClass:self], @"First object in nib '%@' was '%@'. Expected '%@'", nibName, view, self);
        return view;
    }
    
    //return empty view
    return [[[self class] alloc] init];
}

- (void)loadContentsWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil
{
    NSString *nibName = nibNameOrNil ?: NSStringFromClass([self class]);
    UIView *view = [UIView instanceWithNibName:nibName bundle:bundleOrNil owner:self];
    if (view)
    {
        if (CGSizeEqualToSize(self.frame.size, CGSizeZero))
        {
            //if we have zero size, set size from content
            self.size = view.size;
        }
        else
        {
            //otherwise set content size to match our size
            view.frame = self.contentBounds;
        }
        [self addSubview:view];
    }
}

+(void)MoveView:(UIView *)view To:(CGRect)frame During:(float)time
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:time];
    view.frame = frame;
    [UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString: SHOW_VIEW]) {

    } else if ([animationID isEqualToString:HIDDEN_VIEW]) {

    }
}

+(void)ShowView:(UIView *)view To:(CGRect)frame During:(float)time delegate:(id)delegate
{
    [UIView beginAnimations:SHOW_VIEW context:(void *)view];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    if(delegate !=nil &&[delegate respondsToSelector:@selector(onAnimationComplete:finished:context:)]){
        [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
        [UIView setAnimationDelegate:delegate];
    }
    view.hidden = NO;
    view.layer.opacity = 1;
    view.frame = frame;
    [UIView commitAnimations];
}

+(void)HiddenView:(UIView *)view To:(CGRect)frame During:(float)time delegate:(id)delegate
{
    [UIView beginAnimations:HIDDEN_VIEW context:(void *)view];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if(delegate !=nil &&[delegate respondsToSelector:@selector(onAnimationComplete:finished:context:)]){
        [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
        [UIView setAnimationDelegate:delegate];
    }
    view.frame = frame;
    view.layer.opacity = 0.0;
    [UIView commitAnimations];
}

//view searching

- (UIView *)viewMatchingPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return self;
    }
    for (UIView *view in self.subviews)
    {
        UIView *match = [view viewMatchingPredicate:predicate];
        if (match) return match;
    }
    return nil;
}

- (UIView *)viewWithTag:(NSInteger)tag ofClass:(Class)viewClass
{
    return [self viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused NSDictionary *bindings) {
        return [evaluatedObject tag] == tag && [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (UIView *)viewOfClass:(Class)viewClass
{
    return [self viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (NSArray *)viewsMatchingPredicate:(NSPredicate *)predicate
{
    NSMutableArray *matches = [NSMutableArray array];
    if ([predicate evaluateWithObject:self])
    {
        [matches addObject:self];
    }
    for (UIView *view in self.subviews)
    {
        //check for subviews
        //avoid creating unnecessary array
        if ([view.subviews count])
        {
        	[matches addObjectsFromArray:[view viewsMatchingPredicate:predicate]];
        }
        else if ([predicate evaluateWithObject:view])
        {
            [matches addObject:view];
        }
    }
    return matches;
}

- (NSArray *)viewsWithTag:(NSInteger)tag
{
    return [self viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject tag] == tag;
    }]];
}

- (NSArray *)viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass
{
    return [self viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject tag] == tag && [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (NSArray *)viewsOfClass:(Class)viewClass
{
    return [self viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (UIView *)firstSuperviewMatchingPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return self;
    }
    return [self.superview firstSuperviewMatchingPredicate:predicate];
}

- (UIView *)firstSuperviewOfClass:(Class)viewClass
{
    return [self firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return [superview isKindOfClass:viewClass];
    }]];
}

- (UIView *)firstSuperviewWithTag:(NSInteger)tag
{
    return [self firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview.tag == tag;
    }]];
}

- (UIView *)firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass
{
    return [self firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview.tag == tag && [superview isKindOfClass:viewClass];
    }]];
}

- (BOOL)viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return YES;
    }
    return [self.superview viewOrAnySuperviewMatchesPredicate:predicate];
}

- (BOOL)viewOrAnySuperviewIsKindOfClass:(Class)viewClass
{
    return [self viewOrAnySuperviewMatchesPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return [superview isKindOfClass:viewClass];
    }]];
}

- (BOOL)isSuperviewOfView:(UIView *)view
{
    return [self firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview == view;
    }]] != nil;
}

- (BOOL)isSubviewOfView:(UIView *)view
{
    return [view isSuperviewOfView:self];
}

-(void)removeAllSubViews
{
    for (UIView* subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

+(UIWindow *)rootWindow
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow * window = delegate.window;
    return window;
}

//responder chain

- (UIViewController *)firstViewController
{
    id responder = self;
    while ((responder = [responder nextResponder]))
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return responder;
        }
    }
    return nil;
}

- (UIView *)firstResponder
{
    return [self viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject isFirstResponder];
    }]];
}

//frame accessors

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

/* center */
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

//bounds accessors

- (CGSize)boundsSize
{
    return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)size
{
    CGRect bounds = self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}

- (CGFloat)boundsWidth
{
    return self.boundsSize.width;
}

- (void)setBoundsWidth:(CGFloat)width
{
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)boundsHeight
{
    return self.boundsSize.height;
}

- (void)setBoundsHeight:(CGFloat)height
{
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}

//content getters

- (CGRect)contentBounds
{
    return CGRectMake(0.0f, 0.0f, self.boundsWidth, self.boundsHeight);
}

- (CGPoint)contentCenter
{
    return CGPointMake(self.boundsWidth/2.0f, self.boundsHeight/2.0f);
}

//additional frame setters

- (void)setLeft:(CGFloat)left right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.size.width = right - left;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - width;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    frame.size.height = bottom - top;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - height;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterWithHeight:(CGFloat)height
{
    CGPoint tCenter = self.center;
    tCenter.y = height/2;
    
    self.center = tCenter;
}

//animation

- (void)crossfadeWithDuration:(NSTimeInterval)duration
{
    //jump through a few hoops to avoid QuartzCore framework dependency
    CAAnimation *animation = [NSClassFromString(@"CATransition") animation];
    [animation setValue:@"kCATransitionFade" forKey:@"type"];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion
{
    [self crossfadeWithDuration:duration];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}


- (void)adjustFrameHeightHasStateBar:(BOOL)hasStateBar
                    hasNavigationBar:(BOOL)hasNavigationBar
                           hasTabBar:(BOOL)hasTabBar
                    bottomViewHeight:(NSUInteger)bottomViewHeight
{
    [self adjustFrameHeightHasStateBar:hasStateBar hasNavigationBar:hasNavigationBar hasTabBar:hasTabBar];
    self.height -= bottomViewHeight;
}

#define TAG_FOR_NUMBER_LABEL 0x99A0
#define TAG_FOR_POINT_LABEL 0x99A1
#define TAG_FOR_ELLIPTIC_LABEL 0x99A2

//添加圆形数字控件
-(void)displayRoundNumberWithPoint:(CGPoint)ori number:(u_int8_t)number
{
    UILabel* numberLabel = [self labelWithTag:TAG_FOR_NUMBER_LABEL];
    if (!numberLabel) {
        numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        numberLabel.tag = TAG_FOR_NUMBER_LABEL;
        numberLabel.size = CGSizeMake(20, 20);
        [numberLabel setBorder:[UIColor whiteColor] width:1.5];
        [numberLabel setCornerRadius:numberLabel.size.width/2];
        numberLabel.backgroundColor = [UIColor redColor];
        numberLabel.font = [UIFont boldSystemFontOfSize:10];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:numberLabel];
    }
    	
    numberLabel.origin = ori;
    numberLabel.text = number < 100?[NSString stringWithFormat:@"%u",number]:@"99+";
}

-(void)displayRoundNumberWithPoint:(CGPoint)ori
{
    UILabel* numberLabel = [self labelWithTag:TAG_FOR_POINT_LABEL];
    if (!numberLabel) {
        numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        numberLabel.tag = TAG_FOR_POINT_LABEL;
        numberLabel.size = CGSizeMake(10, 10);
        [numberLabel setBorder:[UIColor whiteColor] width:1.2];
        [numberLabel setCornerRadius:numberLabel.size.width/2];
        numberLabel.backgroundColor = [UIColor redColor];

        [self addSubview:numberLabel];
    }

    numberLabel.origin = ori;
}
//默认右上方显示
-(void)displayRoundPoint
{
    CGPoint point = CGPointMake(self.bounds.size.width-15.0, 5.0);

    [self displayRoundNumberWithPoint:point];
}

-(void)displayRoundNumber:(u_int8_t)number
{
    CGPoint point = CGPointMake(self.bounds.size.width-25.0f, 0);
    
    [self displayRoundNumberWithPoint:point number:number];
}

-(void)displayRoundNumberWithWidth:(CGFloat)width number:(u_int8_t)number
{
    CGPoint point = CGPointMake(self.bounds.size.width-width, 0);
    UILabel* numberLabel = [self labelWithTag:TAG_FOR_NUMBER_LABEL];
    if (!numberLabel) {
        numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        numberLabel.tag = TAG_FOR_NUMBER_LABEL;
        numberLabel.size = CGSizeMake(width, width);
        numberLabel.font = [UIFont boldSystemFontOfSize:10];
        [numberLabel setBorder:[UIColor whiteColor] width:1.2];
        [numberLabel setCornerRadius:numberLabel.size.width/2];
        numberLabel.backgroundColor = [UIColor redColor];
        numberLabel.adjustsFontSizeToFitWidth = YES;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:numberLabel];
    }
    numberLabel.origin = point;
    numberLabel.text = number < 100?[NSString stringWithFormat:@"%u",number]:@"99+";
}



-(void)removeRoundNumber
{
    UILabel* numberLabel = [self labelWithTag:TAG_FOR_NUMBER_LABEL];
    if (numberLabel) {
        [numberLabel removeFromSuperview];
    }
}

-(void)removeRoundPoint
{
    UILabel* numberLabel = [self labelWithTag:TAG_FOR_POINT_LABEL];
    if (numberLabel) {
        [numberLabel removeFromSuperview];
    }
}

//添加椭圆形数字控件
-(void)displayEllipticStringWithPoint:(CGPoint)ori string:(NSString*)string
{
    UILabel* numberLabel = [self labelWithTag:TAG_FOR_ELLIPTIC_LABEL];
    if (!numberLabel) {
        numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        numberLabel.tag = TAG_FOR_ELLIPTIC_LABEL;
        numberLabel.size = CGSizeMake(25, 20);
        [numberLabel setBorder:[UIColor whiteColor] width:1.5];
        [numberLabel setCornerRadius:8];
        numberLabel.backgroundColor = [UIColor redColor];
        numberLabel.font = [UIFont boldSystemFontOfSize:10];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:numberLabel];
    }
    
    numberLabel.origin = ori;
    numberLabel.text = string;
}

-(void)displayEllipticString:(NSString*)string
{
    CGPoint point = CGPointMake(self.bounds.size.width-20.0f, 0);
    if (!string) {
        [self removeEllipticString];
        return;
    }
    [self displayEllipticStringWithPoint:point string:string];
}
-(void)displayellipticStringAfterTitle: (NSString *)string
{
    CGPoint point = CGPointMake(self.bounds.size.width-20.0f, 0);
    if (!string) {
        [self removeEllipticString];
        return;
    }
    [self displayEllipticStringWithPoint:point string:string];

}
-(void)removeEllipticString
{
    UILabel* numberLabel = [self labelWithTag:TAG_FOR_ELLIPTIC_LABEL];
    if (numberLabel) {
        [numberLabel removeFromSuperview];
    }
}

- (void)setTapGestureWithEvent:(TapGestureBlock)block
{
    if (!block) {
        return;
    }
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestruePressed:)];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(self, @selector(setTapGestureWithEvent:), block, OBJC_ASSOCIATION_RETAIN);
    
}

- (void)tapGestruePressed:(UITapGestureRecognizer *) gesture
{
    TapGestureBlock block = objc_getAssociatedObject(self, @selector(setTapGestureWithEvent:));
    block(gesture.view);
}


@end

@implementation UIView(LayerEffects)

/* simple setting using the layer */
- (void) setCornerRadius : (CGFloat) radius {
    self.layer.masksToBounds = YES;
	self.layer.cornerRadius = radius;
}

- (void) setBorder : (UIColor *) color width : (CGFloat) width  {
	self.layer.borderColor = [color CGColor];
	self.layer.borderWidth = width;
}

- (void) setShadow : (UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius {
	CALayer *l = self.layer;
	l.shadowColor = [color CGColor];
	l.shadowOpacity = opacity;
	l.shadowOffset = offset;
	l.shadowRadius = blurRadius;
}


@end

@implementation UIView (TagExtensions)
- (UIAlertView *) alertViewWithTag: (NSInteger) aTag
{
	return (UIAlertView *)[self viewWithTag:aTag];
}

- (UIActionSheet *) actionSheetWithTag: (NSInteger) aTag
{
	return (UIActionSheet *)[self viewWithTag:aTag];
}

- (UITableView *) tableViewWithTag: (NSInteger) aTag
{
	return (UITableView *)[self viewWithTag:aTag];
}

- (UITableViewCell *) tableViewCellWithTag: (NSInteger) aTag
{
	return (UITableViewCell *)[self viewWithTag:aTag];
}

- (UIImageView *) imageViewWithTag: (NSInteger) aTag
{
	return (UIImageView *)[self viewWithTag:aTag];
}

- (UIWebView *) webViewWithTag: (NSInteger) aTag
{
	return (UIWebView *)[self viewWithTag:aTag];
}

- (UITextView *) textViewWithTag: (NSInteger) aTag
{
	return (UITextView *)[self viewWithTag:aTag];
}

- (UIScrollView *) scrollViewWithTag: (NSInteger) aTag
{
	return (UIScrollView *)[self viewWithTag:aTag];
}

- (UIPickerView *) pickerViewWithTag: (NSInteger) aTag
{
	return (UIPickerView *)[self viewWithTag:aTag];
}

- (UIDatePicker *) datePickerWithTag: (NSInteger) aTag
{
	return (UIDatePicker *)[self viewWithTag:aTag];
}

- (UISegmentedControl *) segmentedControlWithTag: (NSInteger) aTag
{
	return (UISegmentedControl *)[self viewWithTag:aTag];
}

- (UILabel *) labelWithTag: (NSInteger) aTag
{
	return (UILabel *)[self viewWithTag:aTag];
}

- (UIButton *) buttonWithTag: (NSInteger) aTag
{
	return (UIButton *)[self viewWithTag:aTag];
}

- (UITextField *) textFieldWithTag: (NSInteger) aTag
{
	return (UITextField *)[self viewWithTag:aTag];
}

- (UISwitch *) switchWithTag: (NSInteger) aTag
{
	return (UISwitch *)[self viewWithTag:aTag];
}

- (UISlider *) sliderWithTag: (NSInteger) aTag
{
	return (UISlider *)[self viewWithTag:aTag];
}

- (UIProgressView *) progressViewWithTag: (NSInteger) aTag
{
	return (UIProgressView *)[self viewWithTag:aTag];
}

- (UIActivityIndicatorView *) activityIndicatorViewWithTag: (NSInteger) aTag
{
	return (UIActivityIndicatorView *)[self viewWithTag:aTag];
}

- (UIPageControl *) pageControlWithTag: (NSInteger) aTag
{
	return (UIPageControl *)[self viewWithTag:aTag];
}

- (UIWindow *) windowWithTag: (NSInteger) aTag
{
	return (UIWindow *)[self viewWithTag:aTag];
}

- (UISearchBar *) searchBarWithTag: (NSInteger) aTag
{
	return (UISearchBar *)[self viewWithTag:aTag];
}

- (UINavigationBar *) navigationBarWithTag: (NSInteger) aTag
{
	return (UINavigationBar *)[self viewWithTag:aTag];
}

- (UIToolbar *) toolbarWithTag: (NSInteger) aTag
{
	return (UIToolbar *)[self viewWithTag:aTag];
}

- (UITabBar *) tabBarWithTag: (NSInteger) aTag
{
	return (UITabBar *)[self viewWithTag:aTag];
}

@end

@implementation UIView (AutoAdjustment)

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度

#define Iphone35ScreenWidth 320
#define Iphone4ScreenWidth 320
#define Iphone47ScreenWidth 375
#define Iphone55ScreenWidth 414

+ (CGRect)autosizeWithx:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    CGFloat autoSizeScaleX, autoSizeScaleY;
    
    if(ScreenHeight > 480){
        autoSizeScaleX = ScreenWidth/320;
        autoSizeScaleY = ScreenHeight/568;
    }else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGRect frame;
    frame.origin.x = x * autoSizeScaleX;
    frame.origin.y = y * autoSizeScaleY;
    frame.size.width = w * autoSizeScaleX;
    frame.size.height = h * autoSizeScaleY;
    
    return frame;
}

+ (CGFloat)getAutoSizeScaleByScreenType:(HardwareScreenType)screenType
{
    CGFloat autoSizeScaleX = (ScreenWidth) / (Iphone35ScreenWidth);
    
    switch (screenType) {
        case HardwareScreenType35:
            autoSizeScaleX = (ScreenWidth) / (Iphone35ScreenWidth);
            break;
        case HardwareScreenType4:
            autoSizeScaleX = (ScreenWidth) / (Iphone4ScreenWidth);
            break;
        case HardwareScreenType47:
            autoSizeScaleX = (ScreenWidth) / (Iphone47ScreenWidth);
            break;
        case HardwareScreenType55:
            autoSizeScaleX = (ScreenWidth) / (Iphone55ScreenWidth);
            break;
            
        default:
            break;
    }
    
    return autoSizeScaleX;
}

+ (CGRect)autoFrame:(CGRect)frame byScreenType:(HardwareScreenType)screenType
{
   CGRect newFrame = frame;
#ifdef TARGET_SUPPORT_IPHONE6PLUS
    CGFloat autoSizeScaleX = [self getAutoSizeScaleByScreenType:screenType];
    newFrame.origin.x = frame.origin.x * autoSizeScaleX;
    newFrame.origin.y = frame.origin.y * autoSizeScaleX;
    newFrame.size.width = frame.size.width * autoSizeScaleX;
    newFrame.size.height = frame.size.height * autoSizeScaleX;
    
#endif
    return newFrame;
}

+ (CGRect)autoFrame:(CGRect)frame
{
    return [[self class] autoFrame:frame byScreenType:HardwareScreenType55];
}

+ (CGFloat)autoWidth:(CGFloat)width byScreenType:(HardwareScreenType)screenType
{
    return width * [self getAutoSizeScaleByScreenType:screenType];
}

@end


@implementation UIView (PrintHelper)

+ (void)printRect:(CGRect)rect withPreString:(NSString *)preStr
{
    NSLog(@"%@ (%f, %f, %f, %f)", preStr, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

+ (void)printSize:(CGSize)size withPreString:(NSString *)preStr
{
    NSLog(@"%@ (%f, %f)", preStr, size.width, size.height);
}

+ (void)printPoint:(CGPoint)point withPreString:(NSString *)preStr
{
    NSLog(@"%@ (%f, %f)", preStr, point.x, point.y);
}

@end

@implementation UIView (customizeView)
+ (UIView *)createViewWithBackgroudImage:(UIImage *)image frame:(CGRect)frame tag:(NSInteger)tag
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    if (image) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:view.bounds];
        iv.image = image;
        iv.tag = tag;
        [view addSubview:iv];
    }
    
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}
@end
