//
//  CSSConditionalProperty.m
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "CSSConditionalProperty.h"

@implementation CSSConditionalProperty
CSSConditionalProperty *CSSPropertyMake(id value, id oppositeValue, NSArray *predicates) {
    CSSConditionalProperty *property = [CSSConditionalProperty new];
    property.value = value;
    property.oppositeValue = oppositeValue;
    property.predicates = predicates;
    return property;
}
@end
