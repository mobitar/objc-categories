//
//  CSSHelper.h
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSS.h"


@interface CSSHelper : NSObject
- (id)valueForProperty:(CSSPropertyType)property fromClass:(Class<CSS>)css forDivId:(NSString*)id;
@end

#pragma mark Category

@interface NSObject (CSS)
@property (nonatomic, copy) NSString *divID;
- (void)stylizeWithCSSClass:(Class<CSS>)css;
- (void)stylizeItem:(id)item divKey:(NSString*)key withCSSClass:(Class<CSS>)css;
+ (void)configureItem:(id)item withCocoaKey:(NSString*)cocoaKey value:(id)value parentItem:(id)parentItem;
@end

@interface UIView (CSS)
- (void)setHighlighted:(BOOL)highlighted;
- (BOOL)isHighlighted;
@end