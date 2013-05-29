//
//  MBTextField.m
//  Mass
//
//  Created by Mo Bitar on 5/27/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "MBTextField.h"

@implementation MBTextField

- (void)drawPlaceholderInRect:(CGRect)rect {
    NSString *string = self.placeholder;
    CGSize textSize = [string sizeWithFont:self.placeholderFont];
    [self.placeholderColor set];
    rect.origin.y = rect.size.height/2.0 - textSize.height/2.0;
    [string drawInRect:rect withFont:self.placeholderFont];
}

@end
