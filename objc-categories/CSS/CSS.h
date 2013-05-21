//
//  CSS.h
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSSRelationship.h"
#import "CSSConditionalProperty.h"
#import "CSSKeyPath.h"
#import "CSSConstants.h"

@protocol CSS <NSObject>
@optional
+ (NSDictionary*)selfProperties;
@end
