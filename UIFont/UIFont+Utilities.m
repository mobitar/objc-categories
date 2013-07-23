//
//  UIFont+Grid.m
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UIFont+Utilities.h"

@implementation UIFont (Utilities)

#define NEUE @"HelveticaNeue"
#define NEUEBOLD @"HelveticaNeue-Bold"
#define NEUEULTRALIGHT @"HelveticaNeue-UltraLight"

+ (UIFont*)helveticaNeueOfSize:(CGFloat)size
{
    return [UIFont fontWithName:NEUE size:size];
}

+ (UIFont*)boldHelveticaNeueOfSize:(CGFloat)size
{
    return [UIFont fontWithName:NEUEBOLD size:size];
}

+ (UIFont*)lightHelveticaNeueFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont*)italicLightHelveticaNeueFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:size];
}

+ (UIFont*)ultraLightHelveticaNeueFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:NEUEULTRALIGHT size:size];
}

@end
