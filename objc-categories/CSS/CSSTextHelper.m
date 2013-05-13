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

/*
 UIKIT_EXTERN NSString *const NSFontAttributeName NS_AVAILABLE_IOS(6_0);                // UIFont, default Helvetica(Neue) 12
 UIKIT_EXTERN NSString *const NSParagraphStyleAttributeName NS_AVAILABLE_IOS(6_0);      // NSParagraphStyle, default defaultParagraphStyle
 UIKIT_EXTERN NSString *const NSForegroundColorAttributeName NS_AVAILABLE_IOS(6_0);     // UIColor, default blackColor
 UIKIT_EXTERN NSString *const NSBackgroundColorAttributeName NS_AVAILABLE_IOS(6_0);     // UIColor, default nil: no background
 UIKIT_EXTERN NSString *const NSLigatureAttributeName NS_AVAILABLE_IOS(6_0);            // NSNumber containing integer, default 1: default ligatures, 0: no ligatures, 2: all ligatures (Note: 2 is unsupported on iOS)
 UIKIT_EXTERN NSString *const NSKernAttributeName NS_AVAILABLE_IOS(6_0);                // NSNumber containing floating point value, in points; amount to modify default kerning. 0 means kerning is disabled. (note: values other than nil and 0 are unsupported on iOS)
 UIKIT_EXTERN NSString *const NSStrikethroughStyleAttributeName NS_AVAILABLE_IOS(6_0);  // NSNumber containing integer, default 0: no strikethrough
 UIKIT_EXTERN NSString *const NSUnderlineStyleAttributeName NS_AVAILABLE_IOS(6_0);      // NSNumber containing integer, default 0: no underline
 UIKIT_EXTERN NSString *const NSStrokeColorAttributeName NS_AVAILABLE_IOS(6_0);         // UIColor, default nil: same as foreground color
 UIKIT_EXTERN NSString *const NSStrokeWidthAttributeName NS_AVAILABLE_IOS(6_0);         // NSNumber containing floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0)
 UIKIT_EXTERN NSString *const NSShadowAttributeName NS_AVAILABLE_IOS(6_0);              // NSShadow, default nil: no shadow
 */

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
        [CSSHelper configureItem:item withCocoaKey:cocoaKey value:attributes[attribute] parentItem:parentItem];
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
