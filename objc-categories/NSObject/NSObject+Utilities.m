//
//  NSObject+Utilities.m
//  nubhub
//
//  Created by Bitar on 3/19/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "NSObject+Utilities.h"

@implementation NSObject (Utilities)

- (BOOL)isKeyValueCompliantForKey:(NSString*)key {
    NSString *setterName = [NSString stringWithFormat: @"set%@%@:", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
    BOOL hasSetter = NO;
    SEL setterSEL = NSSelectorFromString(setterName);
    if([self respondsToSelector: setterSEL]) {
        hasSetter = YES;
    }
    
    BOOL hasGetter = NO;
    SEL getterSEL = NSSelectorFromString(key);
    if([self respondsToSelector: getterSEL]) {
        hasGetter = YES;
    }
    return hasGetter && hasSetter;
}

@end
