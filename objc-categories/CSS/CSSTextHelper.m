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

+ (NSDictionary*)attributedTextMapping {
    return @{
             @(CSSTextColor) : NSForegroundColorAttributeName,
             @(CSSTextFont)  : NSFontAttributeName,
             @(CSSTextLetterSpacing) : NSKernAttributeName
             };
}

+ (NSArray *)attributedStringAttributes {
    return @[@(CSSTextLetterSpacing)];
}

+ (void)setupTextForItem:(id)item parentItem:(id)parentItem usingAttributes:(NSDictionary*)attributes {
    BOOL isAttributed = [self isAttributedStringForAttributes:attributes];
    if(isAttributed) {
        [self setupAttributedTextForItem:item parentItem:parentItem usingAttributes:attributes];
    } else {
        [self setupPlainTextForItem:item parentItem:(id)parentItem usingAttributes:attributes];
    }
}

+ (void)setupPlainTextForItem:(id)item parentItem:(id)parentItem usingAttributes:(NSDictionary*)attributes {
    NSDictionary *mapping = [self plainTextMapping];
    for(NSNumber *attribute in attributes) {
        NSString *cocoaKey = mapping[attribute];
        [UIView configureItem:item withCocoaKey:cocoaKey value:attributes[attribute] parentItem:parentItem];
    }
}

+ (void)setupAttributedTextForItem:(id)item parentItem:(id)parentItem usingAttributes:(NSDictionary*)attributes {
    id text = attributes[@(CSSText)];
    if(is(text, CSSKeyPath)) {
        text = [text evaluateWithItem:item parentItem:parentItem];
    }
    if(!text)
        return;
    NSDictionary *mapping = [self attributedTextMapping];
    NSMutableDictionary *stringAttributes = [NSMutableDictionary new];
    for(NSNumber *attribute in attributes) {
        NSString *attributeName = mapping[attribute];
        if(attributeName)
            stringAttributes[attributeName] = attributes[attribute];
    }
    if(attributes[@(CSSTextShadowColor)]) {
        NSShadow *shadow = [NSShadow new];
        shadow.shadowBlurRadius = [attributes[@(CSSTextShadowBlurRadius)] floatValue];
        shadow.shadowColor = attributes[@(CSSTextShadowColor)];
        shadow.shadowOffset = [attributes[@(CSSTextShadowOffset)] CGSizeValue];
    }
    if(attributes[@(CSSTextAlignment)]) {
        [item setTextAlignment:[attributes[@(CSSTextAlignment)] integerValue]];
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text attributes:stringAttributes];
    [item setAttributedText:attrString];
}

+ (BOOL)isAttributedStringForAttributes:(NSDictionary*)attributes {
    for(id attribute in [self attributedStringAttributes]) {
        if([attributes.allKeys containsObject:attribute])
            return YES;
    }
    return NO;
}
@end
