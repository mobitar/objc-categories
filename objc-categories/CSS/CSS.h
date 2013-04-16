//
//  CSS.h
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    CSSHeight = 0,
    CSSHorizontalMargin,
    CSSFont,
    CSSColor,
    CSSBackgroundColor,
    CSSTextAlignment,
    CSSVerticalAlignment,
    CSSOpacity
} CSSProperty;

@protocol CSS <NSObject>
+ (NSDictionary*)mainProperties;
@end
