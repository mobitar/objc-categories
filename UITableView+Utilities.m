//
//  UITableView+Utilities.m
//  Protips
//
//  Created by Mo Bitar on 8/3/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UITableView+Utilities.h"

@implementation UITableView (Utilities)
- (CGFloat)heightForString:(NSString*)string withFont:(UIFont*)font padding:(UIEdgeInsets)padding
{
    CGSize constraint = CGSizeMake(CGRectGetWidth(self.bounds) - (padding.left + padding.right), MAXFLOAT);
    CGSize size = [string sizeWithFont:font constrainedToSize:constraint lineBreakMode:NSLineBreakByClipping];
    return size.height;
    
}
@end
