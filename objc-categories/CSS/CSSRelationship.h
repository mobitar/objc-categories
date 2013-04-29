//
//  CSSRelationship.h
//  Grid
//
//  Created by Mo Bitar on 4/16/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CSSRelationshipCenterHorizontally,
    CSSRelationshipCenterVertically,
    CSSRelationshipTrailVertically,
    CSSRelationshipLeadingVerticalSpace,
    CSSRelationshipWidth,
    CSSRelationshipHeight,
    CSSRelationshipTopPosition,
    CSSRelationshipBottomPosition,
    CSSRelationshipLeftPosition,
    CSSRelationshipRightPosition,
} CSSRelationshipType;

@interface CSSRelationship : NSObject
@property (nonatomic, copy) NSString * relatedToKeyPath;
@property (nonatomic) CSSRelationshipType relationshipType;
@property (nonatomic) CGFloat offset;
@property (nonatomic) NSArray *conditionals;

+ (NSLayoutAttribute)attributeForRelationshipType:(CSSRelationshipType)type;
CSSRelationship *CSSRelationshipMake(CSSRelationshipType type, NSString *viewKeyPath, CGFloat offset);

// relationship will only be applied if parentItem keypaths in "conditionals" all evaluate to YES, respectively
CSSRelationship *CSSRelationshipMakeWithConditionals(CSSRelationshipType type, NSString *viewKeyPath, CGFloat offset, NSArray *conditionals);
@end
