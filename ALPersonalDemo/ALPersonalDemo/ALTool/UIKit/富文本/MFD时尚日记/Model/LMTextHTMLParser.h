//
//  LMTextHTMLParser.h
//  SimpleWord
//
//  Created by Chenly on 16/6/27.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMTextHTMLParser : NSObject

/** 预览用 */
+ (NSMutableString *)htmlDraftFromAttributedString:(NSAttributedString *)attributedString;
@end
