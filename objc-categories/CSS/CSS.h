//
//  CSS.h
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSSRelationshipObject.h"

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
    CSSRelationships
} CSSProperty;

@protocol CSS <NSObject>
@optional
+ (NSDictionary*)mainProperties;
@end
