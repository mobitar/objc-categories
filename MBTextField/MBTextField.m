
#import "MBTextField.h"

@implementation MBTextField

- (void)drawPlaceholderInRect:(CGRect)rect
{
    NSString *string = self.placeholder;
    UIFont *font = self.placeholderFont ?: self.font;
    CGFloat height = [string heightWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect.origin.y = rect.size.height/2.0 - height/2.0;
    [string mb_drawInRect:rect withFont:font color:self.placeholderColor ?: [UIColor lightGrayColor]];
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.placeholderInset.width, self.placeholderInset.height);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.textInset.width, self.textInset.height);
}

@end
