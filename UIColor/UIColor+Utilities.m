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

- (UIColor *)colorWithHueOffset:(CGFloat)hueOffset
{
    UIColor *newColor = nil;
    CGFloat hue, saturation, brightness, alpha;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
    {
        // We wants the hue value to be between 0 - 1 after appending the offset
        CGFloat newHue = fmodf((hue + hueOffset), 1);
        newColor = [UIColor colorWithHue:newHue saturation:saturation brightness:brightness alpha:alpha];
        
    }
    return newColor;
}

- (UIColor *)colorWithSaturationOffset:(CGFloat)saturationOffset
{
    UIColor *newColor = nil;
    CGFloat hue, saturation, brightness, alpha;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
    {
        // We wants the hue value to be between 0 - 1 after appending the offset
        CGFloat newSaturation = fmodf((saturation + saturationOffset), 1);
        newColor = [UIColor colorWithHue:hue saturation:newSaturation brightness:brightness alpha:alpha];
    }
    return newColor;
}

- (UIColor *)colorWithBrightnessOffset:(CGFloat)brightnessOffset
{
    UIColor *newColor = nil;
    CGFloat hue, saturation, brightness, alpha;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
    {
        // We wants the hue value to be between 0 - 1 after appending the offset
        CGFloat newBrightness = MIN((brightness + brightnessOffset), 1);
        newColor = [UIColor colorWithHue:hue saturation:saturation brightness:newBrightness alpha:alpha];
    }
    return newColor;
}
@end
