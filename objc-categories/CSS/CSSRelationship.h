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
@property (nonatomic) NSArray *predicates;

+ (NSLayoutAttribute)attributeForRelationshipType:(CSSRelationshipType)type;
CSSRelationship *CSSRelationshipMake(CSSRelationshipType type, NSString *viewKeyPath, CGFloat offset);
CSSRelationship *CSSRelationshipMakeWithConditionals(CSSRelationshipType type, NSString *viewKeyPath, CGFloat offset, NSArray *predicates);

#define CSSRelationshipZeroOrigin() \
    CSSRelationshipMake(CSSRelationshipTopPosition, @"self.superview", 0), \
    CSSRelationshipMake(CSSRelationshipLeftPosition, @"self.superview", 0)

#define CSSRelationshipCenterInSuperview() \
    CSSRelationshipMake(CSSRelationshipCenterHorizontally, @"self.superview", 0), \
    CSSRelationshipMake(CSSRelationshipCenterVertically, @"self.superview", 0) 
@end
