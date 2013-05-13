//
//  CSSConditionalProperty.m
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "CSSConditionalProperty.h"

@implementation CSSConditionalProperty
CSSConditionalProperty *CSSConditionalPropertyMake(id value, id oppositeValue, NSArray *predicates) {
    CSSConditionalProperty *property = [CSSConditionalProperty new];
    property.value = value;
    property.oppositeValue = oppositeValue;
    property.predicates = predicates;
    return property;

}

CSSConditionalProperty *CSSPropertyMappingMake(NSArray *predicateMappings) {
    CSSConditionalProperty *property = [CSSConditionalProperty new];
    property.predicatesToValuesMapping = predicateMappings;
    return property;
}

- (id)evaluateMappingsWithObject:(id)object {
    for(NSDictionary *dictionary in self.predicatesToValuesMapping) {
        NSPredicate *predicate = dictionary[@"predicate"];
        if([predicate evaluateWithObject:object]) {
            return dictionary[@"value"];
        }
    }
    return nil;
}

NSDictionary *CSSPredicateValueMappingMake(NSPredicate *predicate, id value) {
    return @{@"predicate" : predicate, @"value" : value};
}
@end
