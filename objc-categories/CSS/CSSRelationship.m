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

+ (NSLayoutAttribute)attributeForRelationshipType:(CSSRelationshipType)type {
    switch (type) {
        case CSSRelationshipLeftPosition:
            return NSLayoutAttributeLeft;
            
        case CSSRelationshipRightPosition:
            return NSLayoutAttributeRight;
            
        case CSSRelationshipBottomPosition:
            return NSLayoutAttributeBottom;
            
        case CSSRelationshipTopPosition:
            return NSLayoutAttributeTop;
            
        case CSSRelationshipWidth:
            return NSLayoutAttributeWidth;
            
        case CSSRelationshipHeight:
            return NSLayoutAttributeHeight;
            
        case CSSRelationshipCenterHorizontally:
            return NSLayoutAttributeCenterX;
            
        case CSSRelationshipCenterVertically:
            return NSLayoutAttributeCenterY;
            
        case CSSRelationshipLeadingVerticalSpace:
            return NSLayoutAttributeTop;
            
        case CSSRelationshipTrailVertically:
            return NSNotFound;
    }
    
    return NSNotFound;
}

@end
