//
//  CSSKeyPath.m
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "CSSKeyPath.h"

@implementation CSSKeyPath
CSSKeyPath *CSSKeyPathMake(NSString *keypath) {
    CSSKeyPath *obj = [CSSKeyPath new];
    obj.keypath = keypath;
    return obj;
}
@end
