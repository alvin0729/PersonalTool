
#import "RJClickCountLabel.h"
#import "RJCommonConstants.h"

@interface RJClickCountLabel ()
@end

@implementation RJClickCountLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
        self.font = GetFont(9);
        self.text = @"11";
    }
    return self;
}
- (void)clikeLabelSizeToFit{
    self.frame = CGRectMake(2, self.superview.viewHeight/2, self.superview.viewWidth, 10);
    [self sizeToFit];
    self.viewWidth = self.viewWidth +10;
}
@end
