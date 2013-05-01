//
//  CSSConditionalProperty.h
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSSConditionalProperty : NSObject
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id oppositeValue;
@property (nonatomic, strong) NSArray *predicatesToValuesMapping;
@property (nonatomic, strong) NSArray *predicates;

- (id)evaluateMappingsWithObject:(id)object;
CSSConditionalProperty *CSSPropertyMake(id value, id oppositeValue, NSArray *predicates);
CSSConditionalProperty *CSSPropertyMappingMake(NSArray *predicateMappings);

NSDictionary *CSSPredicateValueMappingMake(NSPredicate *predicate, id value);
@end
