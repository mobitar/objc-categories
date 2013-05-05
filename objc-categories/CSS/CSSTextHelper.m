//
//  CSSTextHelper.m
//  Grid
//
//  Created by Mo Bitar on 5/5/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "CSSTextHelper.h"
#import "CSSHelper.h"

@implementation CSSTextHelper

+ (NSDictionary*)plainTextMapping {
    return @{
             @(CSSText) : @"text",
             @(CSSTextAlignment) : @"textAlignment",
             @(CSSTextColor) : @"textColor",
             @(CSSTextFont) : @"font",
             @(CSSTextNumberOfLines) : @"numberOfLines",
             @(CSSTextShadowColor) : @"shadowColor",
             @(CSSTextShadowOffset) : @"shadowOffset",
             };
}

+ (NSArray *)attributedStringAttributes {
    return @[];
}

+ (void)setupTextForItem:(id)item parentItem:(id)parentItem usingAttributes:(NSDictionary*)attributes {
    BOOL isAttributed = [self isAttributedStringForAttributes:attributes];
    if(isAttributed) {
        [self setupAttributedTextForItem:item usingAttributes:attributes];
    } else {
        [self setupPlainTextForItem:item parentItem:(id)parentItem usingAttributes:attributes];
    }
}

+ (void)setupPlainTextForItem:(id)item parentItem:(id)parentItem usingAttributes:(NSDictionary*)attributes {
    NSDictionary *mapping = [self plainTextMapping];
    for(NSNumber *attribute in attributes) {
        NSString *cocoaKey = mapping[attribute];
        [CSSHelper configureItem:item withCocoaKey:cocoaKey value:attributes[attribute] parentItem:parentItem];
    }
}

+ (void)setupAttributedTextForItem:(id)item usingAttributes:(NSDictionary*)attributes {
    
}

+ (BOOL)isAttributedStringForAttributes:(NSDictionary*)attributes {
    for(id attribute in [self attributedStringAttributes]) {
        if([attributes.allKeys containsObject:attribute])
            return YES;
    }
    return NO;
}
@end
