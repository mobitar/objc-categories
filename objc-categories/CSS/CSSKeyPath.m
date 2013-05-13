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

- (id)evaluateWithItem:(id)item parentItem:(id)parentItem {
    return [[self.keypath contains:@"self"] ? item : parentItem valueForKeyPath:self.keypath];
}
@end
