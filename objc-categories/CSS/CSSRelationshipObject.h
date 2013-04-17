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
    CSSRelationshipTrailVertically
} CSSRelationshipType;

@interface CSSRelationshipObject : NSObject
@property (nonatomic, copy) NSString * relatedToKeyPath;
@property (nonatomic) CSSRelationshipType relationshipType;
@property (nonatomic) CGFloat offset;
@end
