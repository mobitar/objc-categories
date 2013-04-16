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
- (id)valueForProperty:(CSSProperty)property fromClass:(Class<CSS>)css forDivId:(NSString*)id;
@end

#pragma mark Category

@interface NSObject (CSS)
@property (nonatomic, copy) NSString *divID;
- (void)stylizeWithCSSClass:(Class<CSS>)css;
- (void)stylizeItem:(id)item divKey:(NSString*)key withCSSClass:(Class<CSS>)css;
@end