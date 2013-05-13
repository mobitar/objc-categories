//
//  CSSViewHelper.m
//  Grid
//
//  Created by Mo Bitar on 5/6/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "CSSViewHelper.h"
#import <QuartzCore/QuartzCore.h>

@implementation CSSViewHelper
+ (void)addGradientToItem:(id)item withColors:(NSArray*)colors locations:(NSArray*)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = [item bounds];
    gradient.colors = colors;
    gradient.locations = locations;
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    [[item layer] addSublayer:gradient];
}
@end
