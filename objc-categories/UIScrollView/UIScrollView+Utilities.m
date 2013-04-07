//
//  UIScrollView+Utilities.m
//  Freebie
//
//  Created by Mo Bitar on 4/2/13.
//  Copyright (c) 2013 Ora Interactive. All rights reserved.
//

#import "UIScrollView+Utilities.h"

@implementation UIScrollView (Utilities)

- (void)setContentHeightToFitContentHeightWithOffset:(CGFloat)heightOffset {
    CGFloat height = 0;
    for(UIView *view in self.subviews) {
        CGFloat currentY = view.frame.origin.y + view.frame.size.height;
        height = MAX(height, currentY);
    }
    
    self.contentSize = CGSizeMake(self.contentSize.width, height + heightOffset);
}

@end
