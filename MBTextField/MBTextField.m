
#import "MBTextField.h"

@implementation MBTextField

- (void)drawPlaceholderInRect:(CGRect)rect {
    NSString *string = self.placeholder;
    UIFont *font = self.placeholderFont ?: self.font;
    CGSize textSize = [string sizeWithFont:font];
    [self.placeholderColor ?: [UIColor lightGrayColor] set];
    rect.origin.y = rect.size.height/2.0 - textSize.height/2.0;
    [string drawInRect:rect withFont:font];
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
