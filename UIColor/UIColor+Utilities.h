//
//  UIColor+Utilities.h
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utilities)
+ (UIColor*)randomColor;
- (UIColor *)colorWithHueOffset:(CGFloat)hueOffset;
- (UIColor *)colorWithSaturationOffset:(CGFloat)saturationOffset;
- (UIColor *)colorWithBrightnessOffset:(CGFloat)brightnessOffset;
@end
