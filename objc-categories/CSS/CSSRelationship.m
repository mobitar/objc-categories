//
//  CSSRelationship.m
//  Grid
//
//  Created by Mo Bitar on 4/16/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "CSSRelationship.h"

@implementation CSSRelationship

CSSRelationship *CSSRelationshipMake(CSSRelationshipType type, NSString *viewKeyPath, CGFloat offset) {
    CSSRelationship *relationship = [CSSRelationship new];
    relationship.relatedToKeyPath = viewKeyPath;
    relationship.relationshipType = type;
    relationship.offset = offset;
    return relationship;
}

@end
