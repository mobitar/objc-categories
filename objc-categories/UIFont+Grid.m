//
//  UIFont+Grid.m
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UIFont+Grid.h"

@implementation UIFont (Utilities)

#define NEUE @"HelveticaNeue"
#define NEUEBOLD @"HelveticaNeue-Bold"

+ (UIFont*)helveticaNeueOfSize:(CGFloat)size {
    return [UIFont fontWithName:NEUE size:size];
}

+ (UIFont*)boldHelveticaNeueOfSize:(CGFloat)size {
    return [UIFont fontWithName:NEUEBOLD size:size];
}

@end
