//
//  CSSViewHelper.h
//  Grid
//
//  Created by Mo Bitar on 5/6/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>



@class CAGradientLayer;
@interface CSSViewHelper : NSObject
CAGradientLayer *CSSGradientMake(NSArray* colors, NSArray* locations, CGPoint startPoint, CGPoint endPoint);
@end
