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
    CSSRelationshipLeadingVerticalSpace
} CSSRelationshipType;

@interface CSSRelationship : NSObject
@property (nonatomic, copy) NSString * relatedToKeyPath;
@property (nonatomic) CSSRelationshipType relationshipType;
@property (nonatomic) CGFloat offset;

CSSRelationship *CSSRelationshipMake(CSSRelationshipType type, NSString *viewKeyPath, CGFloat offset);
@end
