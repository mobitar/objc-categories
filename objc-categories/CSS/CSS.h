//
//  CSS.h
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSSRelationship.h"

typedef enum {
    CSSHeight = 0,
    CSSHorizontalPadding,
    CSSFont,
    CSSColor,
    CSSBackgroundColor,
    CSSTextAlignment,
    CSSVerticalAlignment,
    CSSOpacity,
    CSSShadowColor,
    CSSShadowOffset,
    CSSNumberOfLines,
    CSSRelationships,
    CSSSuperview,
    CSSHasDefaultConstraints, // default is NO,
    CSSImage,
    CSSSize
} CSSProperty;

@protocol CSS <NSObject>
@optional
+ (NSDictionary*)mainProperties;
@end
