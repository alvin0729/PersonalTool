//
//  UIView+category.m
//  iLearning
//
//  Created by Sidney on 13-9-4.
//  Copyright (c) 2013年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//


/*
 @property CGPoint aOrigin;//获得视图的起点坐标
 @property CGSize aSize;//获得视图的宽和高
 
 @property (readonly) CGPoint aBottomLeft;
 @property (readonly) CGPoint aBottomRight;
 @property (readonly) CGPoint aTopRight;
 
 @property CGFloat aHeight;//获得视图的高
 @property CGFloat aWidth;//获得视图的宽
 
 @property CGFloat aTop;//获得视图的顶部y
 @property CGFloat aLeft;//获得视图的左部x
 
 @property CGFloat aBottom;//获得视图的底部y
 @property CGFloat aRight;//获得视图的右部x
 */

#import "UIView+Extension.h"

#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

//CGPoint CGRectGetCenter(CGRect rect)
//{
//    CGPoint pt;
//    pt.x = CGRectGetMidX(rect);
//    pt.y = CGRectGetMidY(rect);
//    return pt;
//}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (Extension)


- (BOOL)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    UIWebView *webView = (UIWebView*)aView;
    
    int height = webView.scrollView.contentSize.height;
    
    CGFloat screenHeight = webView.bounds.size.height;
    
    int pages = ceil(height / screenHeight);
    
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, webView.bounds, nil);
    CGRect frame = [webView frame];
    for (int i = 0; i < pages; i++) {
        // Check to screenHeight if page draws more than the height of the UIWebView
        if ((i+1) * screenHeight  > height) {
            CGRect f = [webView frame];
            f.size.height -= (((i+1) * screenHeight) - height);
            [webView setFrame: f];
        }
        
        UIGraphicsBeginPDFPage();
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        //      CGContextTranslateCTM(currentContext, 72, 72); // Translate for 1" margins
        
        [[[webView subviews] lastObject] setContentOffset:CGPointMake(0, screenHeight * i) animated:NO];
        [webView.layer renderInContext:currentContext];
    }
    
    UIGraphicsEndPDFContext();
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    [webView setFrame:frame];
    return YES;
}

- (UIImage *)webviewToImage:(UIWebView*)webView
{
    int currentWebViewHeight = webView.scrollView.contentSize.height;
    int scrollByY = webView.frame.size.height;
    
    [webView.scrollView setContentOffset:CGPointMake(0, 0)];
    
    NSMutableArray* images = [[NSMutableArray alloc] init];
    
    CGRect screenRect = webView.frame;
    
    int pages = currentWebViewHeight/scrollByY;
    if (currentWebViewHeight%scrollByY > 0) {
        pages ++;
    }
    
    for (int i = 0; i< pages; i++)
    {
        if (i == pages-1) {
            if (pages>1)
                screenRect.size.height = currentWebViewHeight - scrollByY;
        }
        
        if (IS_RETINA)
            UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, 0.0f);
        else
            UIGraphicsBeginImageContext( screenRect.size );
        if ([webView.layer respondsToSelector:@selector(setContentsScale:)]) {
            webView.layer.contentsScale = [[UIScreen mainScreen] scale];
        }
        //UIGraphicsBeginImageContext(screenRect.size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [[UIColor blackColor] set];
        CGContextFillRect(ctx, screenRect);
        
        [webView.layer renderInContext:ctx];
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (i == 0)
        {
            scrollByY = webView.frame.size.height;
        }
        else
        {
            scrollByY += webView.frame.size.height;
        }
        [webView.scrollView setContentOffset:CGPointMake(0, scrollByY)];
        [images addObject:newImage];
    }
    
    [webView.scrollView setContentOffset:CGPointMake(0, 0)];
    
    UIImage *resultImage;
    
    if(images.count > 1) {
        //join all images together..
        CGSize size;
        for(int i=0;i<images.count;i++) {
            
            size.width = MAX(size.width, ((UIImage*)[images objectAtIndex:i]).size.width );
            size.height += ((UIImage*)[images objectAtIndex:i]).size.height;
        }
        
        if (IS_RETINA)
            UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
        else
            UIGraphicsBeginImageContext(size);
        if ([webView.layer respondsToSelector:@selector(setContentsScale:)]) {
            webView.layer.contentsScale = [[UIScreen mainScreen] scale];
        }
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [[UIColor blackColor] set];
        CGContextFillRect(ctx, screenRect);
        
        int y=0;
        for(int i=0;i<images.count;i++) {
            
            UIImage* img = [images objectAtIndex:i];
            [img drawAtPoint:CGPointMake(0,y)];
            y += img.size.height;
        }
        
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    } else {
        
        resultImage = [images objectAtIndex:0];
    }
    [images removeAllObjects];
    return resultImage;
}

//----------------------------

// Retrieve and set the origin
- (CGPoint) aOrigin
{
	return self.frame.origin;
}

- (void) setAOrigin: (CGPoint) aPoint
{
	CGRect newframe = self.frame;
	newframe.origin = aPoint;
	self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) aSize
{
	return self.frame.size;
}

- (void) setASize: (CGSize) aSize
{
	CGRect newframe = self.frame;
	newframe.size = aSize;
	self.frame = newframe;
}

// Query other frame locations
- (CGPoint) aBottomRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) aBottomLeft
{
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) aTopRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}

// Retrieve and set height, width, top, bottom, left, right
//获得视图的高
- (CGFloat) aHeight
{
	return self.frame.size.height;
}

- (void) setAHeight: (CGFloat) newheight
{
	CGRect newframe = self.frame;
	newframe.size.height = newheight;
	self.frame = newframe;
}

//获得视图的宽
- (CGFloat) aWidth
{
	return self.frame.size.width;
}

- (void) setAWidth: (CGFloat) newwidth
{
	CGRect newframe = self.frame;
	newframe.size.width = newwidth;
	self.frame = newframe;
}

//获得视图的顶部y
- (CGFloat) aTop
{
	return self.frame.origin.y;
}

- (void) setATop: (CGFloat) newtop
{
	CGRect newframe = self.frame;
	newframe.origin.y = newtop;
	self.frame = newframe;
}

//获得视图的左部x
- (CGFloat) aLeft
{
	return self.frame.origin.x;
}

- (void) setALeft: (CGFloat) newleft
{
	CGRect newframe = self.frame;
	newframe.origin.x = newleft;
	self.frame = newframe;
}

//获得视图的底部y
- (CGFloat) aBottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (void) setABottom: (CGFloat) newbottom
{
	CGRect newframe = self.frame;
	newframe.origin.y = newbottom - self.frame.size.height;
	self.frame = newframe;
}

//获得视图的右部x
- (CGFloat) aRight
{
	return self.frame.origin.x + self.frame.size.width;
}

- (void) setARight: (CGFloat) newright
{
	CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
	CGRect newframe = self.frame;
	newframe.origin.x += delta ;
	self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;
}

//------------事件效应者-----------
-(UIViewController *)viewController
{
    //找到控制器这个响应者
    UIResponder* nextRes = [self nextResponder];
    do{
        if([nextRes isKindOfClass:[UIViewController class]]){
            return (UIViewController*)nextRes;
        }
        nextRes = [nextRes nextResponder];
        
    }while (nextRes != nil);
    //return [CommentMethod getCurrentVC];
    return nil;
}



+ (UIView *)returnViewFrame:(CGRect)aFrame
{

    UIView * view = [[UIView alloc]initWithFrame:aFrame];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (void)keyendEditing
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}








- (void)showShockHUD:(UIView*)hudView
            duration:(NSTimeInterval)duration
          moveVector:(CGPoint)moveVector
          completion:(void (^)(BOOL))completion
{
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone;
    NSTimeInterval delay = 0.0;
    
    [self showShockHUD:hudView
       backgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]
              duration:duration
                 delay:delay
               options:options
            moveVector:moveVector
     completion:completion];
}

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
          moveVector:(CGPoint)moveVector {
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone;
    NSTimeInterval delay = 0.0;
    
    [self showShockHUD:hudView backgroundColor:backgroundColor duration:duration delay:delay options:options moveVector:moveVector completion:nil];
}

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options
          moveVector:(CGPoint)moveVector
completion:(void (^)(BOOL))completion
{
    CGPoint endPoint = CGPointMake(hudView.center.x + moveVector.x, hudView.center.y + moveVector.y);
    
    [self showShockHUD:hudView
       backgroundColor:backgroundColor
              duration:duration
                 delay:delay
               options:options
            animations:^{
                hudView.center = endPoint;
                hudView.alpha = 0.0;
            }
            completion:completion];
}

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options
          animations:(void (^)(void))animations
          completion:(void (^)(BOOL))completion
{
    hudView.backgroundColor = backgroundColor;
    hudView.hidden = NO;
    
    [self addSubview:hudView];
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options:options
                     animations:animations
                     completion:^(BOOL finished){
                         if(completion){
                             completion(finished);
                         }
                         if (finished) {
                             [hudView removeFromSuperview];
                         }
                     }];
}


- (void)addTarget:(id)target action:(SEL)action;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}


@end