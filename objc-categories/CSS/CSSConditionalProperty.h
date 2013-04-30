//
//  CSSConditionalProperty.h
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSSConditionalProperty : NSObject
@property (nonatomic) id value;
@property (nonatomic) id oppositeValue;
@property (nonatomic) NSArray *predicates;
CSSConditionalProperty *CSSPropertyMake(id value, id oppositeValue, NSArray *predicates);
@end
