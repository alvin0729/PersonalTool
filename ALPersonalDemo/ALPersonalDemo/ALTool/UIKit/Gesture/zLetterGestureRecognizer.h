//
//  zLetterGestureRecognizer.h
//  CustomGestureRecognizerDemo
//
//  Created by Jennifer A Sipila on 3/21/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

//https://medium.com/ios-os-x-development/make-a-custom-uigesturerecognizer-in-objective-c-b9099fd8cfa3

#import <UIKit/UIKit.h>


@interface ZLetterGestureRecognizer : UIGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action;

@end
