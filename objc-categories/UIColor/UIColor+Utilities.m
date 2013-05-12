//
//  UIColor+Utilities.m
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UIColor+Utilities.h"

@implementation UIColor (Utilities)

#define rand_val (float)(arc4random() % 255) / 255.0

+ (UIColor*)randomColor {
    return [UIColor colorWithRed:rand_val green:rand_val blue:rand_val alpha:1.0];
}
@end
