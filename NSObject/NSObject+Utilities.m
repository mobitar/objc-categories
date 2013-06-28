//
//  NSObject+Utilities.m
//  nubhub
//
//  Created by Bitar on 3/19/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "NSObject+Utilities.h"
#import <objc/runtime.h>

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

- (void)populateProperties {
    [self populatePropertiesFromMappingDictionary:[self propertiesMapping]];
}

- (NSDictionary*)propertiesMapping {
    return @{};
}

- (void)populatePropertiesFromMappingDictionary:(NSDictionary*)mapping {
    for(NSString *key in mapping) {
        id obj = [self valueForKeyPath:key];
        NSDictionary *propertiesDictonary = mapping[key];
        [obj setValuesForKeysWithDictionary:propertiesDictonary];
    }
}

- (id)initWithDictionary:(NSDictionary*)dictionary {
    [self setValuesForKeysWithDictionary:dictionary];
    return self;
}

- (void)setDynamicValue:(id)value forKey:(NSString *)key
{
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_RETAIN);
}

- (id)getDynamicValueForKey:(NSString *)key
{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

@end
