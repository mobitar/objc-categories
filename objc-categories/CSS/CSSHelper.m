//
//  CSSHelper.m
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "CSSHelper.h"
#import <objc/runtime.h>

@implementation CSSHelper
+ (NSDictionary*)CSStoUIKITMapping {
    return @{
             @(CSSColor)             : @"textColor",
             @(CSSBackgroundColor)   : @"backgroundColor",
             @(CSSFont)              : @"font",
             @(CSSTextAlignment)     : @"textAlignment",
             @(CSSVerticalAlignment) : @"contentVerticalAlignment",
             @(CSSOpacity)           : @"alpha"
             };
}

- (id)valueForProperty:(CSSProperty)property fromClass:(Class<CSS>)css forDivId:(NSString*)id {
    NSDictionary *properties = [css mainProperties];
    return properties[@(property)];
}

@end

#pragma mark --
#pragma mark - CSS Categories

@implementation NSObject (CSS)
- (void)stylizeWithCSSClass:(Class<CSS>)css {
    NSDictionary *mapping = [CSSHelper CSStoUIKITMapping];
    [CSSHelper stylizeItem:self withProperties:[css mainProperties] mapping:mapping];
    
    unsigned propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &propertyCount);
    

    for (unsigned i = 0; i < propertyCount - 1; ++i) {
        objc_property_t prop = properties[i];
        NSString *propertyName = $str(@"%s", property_getName(prop));
        id item = [self valueForKey:propertyName];
        [self.class stylizeItem:item withProperties:[self.class propertiesForDiv:propertyName item:item fromClass:css] mapping:mapping];
    }
}

- (void)stylizeItem:(id)item divKey:(NSString*)key withCSSClass:(Class<CSS>)css {
    [CSSHelper stylizeItem:item withProperties:[self.class propertiesForDiv:key item:item fromClass:css] mapping:[CSSHelper CSStoUIKITMapping]];
}

+ (NSDictionary*)propertiesForDiv:(NSString*)div item:(id)item fromClass:(Class)css {
    SEL selector = NSSelectorFromString(div);
    if(![css respondsToSelector:selector]) {
        return nil;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[css methodSignatureForSelector:selector]];
    invocation.target = css;
    invocation.selector = selector;
    [invocation invoke];
    
    __unsafe_unretained id val = nil;
    [invocation getReturnValue:&val];
    return val;
}

+ (void)stylizeItem:(id)item withProperties:(NSDictionary*)properties mapping:(NSDictionary*)mapping {
    for(NSNumber *propertyKey in properties) {
        NSString *cocoaKey = mapping[propertyKey];
        if([item isKeyValueCompliantForKey:cocoaKey])
            [item setValue:properties[propertyKey] forKey:cocoaKey];
    }
}

static NSString *divIDKey = @"CSSDivID";

- (void)setDivID:(NSString *)divID {
    objc_setAssociatedObject(self, &divIDKey, divID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)divID {
    return objc_getAssociatedObject(self, &divIDKey);
}

@end