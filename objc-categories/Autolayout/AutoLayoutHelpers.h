//
//  AutoLayoutHelpers.h
//
//  Created by Mo Bitar on 5/8/13.
//

#import <Foundation/Foundation.h>
NSLayoutConstraint *constraintEqual(id item1, id item2, NSLayoutAttribute attribute, CGFloat offset);
NSLayoutConstraint *constraintEqualAttributes(id item1, id item2, NSLayoutAttribute attribute1, NSLayoutAttribute attribute2, CGFloat offset);
NSLayoutConstraint *constraintEqualWithMultiplier(id item1, id item2, NSLayoutAttribute attribute, CGFloat offset, CGFloat multiplier);
NSLayoutConstraint *constraintEqualAttributesWithMultiplier(id item1, id item2, NSLayoutAttribute attribute1, NSLayoutAttribute attribute2, CGFloat offset, CGFloat multiplier);
NSLayoutConstraint *constraintWidth(id item1, id item2, CGFloat offset);
NSLayoutConstraint *constraintCenterX(id item1, id item2);
NSLayoutConstraint *constraintCenterY(id item1, id item2);
NSLayoutConstraint *constraintTrailVertically(id item1, id item2, CGFloat offset);
NSLayoutConstraint *constraintHeight(id item1, id item2, CGFloat offset);
NSLayoutConstraint *constraintTop(id item1, id item2, CGFloat offset);
NSLayoutConstraint *constraintBottom(id item1, id item2, CGFloat offset);
NSLayoutConstraint *constraintLeft(id item1, id item2, CGFloat offset);
NSLayoutConstraint *constraintRight(id item1, id item2, CGFloat offset);
NSLayoutConstraint *constraintAbsolute(id item1, NSLayoutAttribute attribute, CGFloat offset);

NSArray *constraintsAbsoluteSize(id item, CGFloat width, CGFloat height);
NSArray *constraintsCenter(id item, id centerTo);
NSArray *constraintsCenterWithOffset(id item, id centerTo, CGFloat xOffset, CGFloat yOffset);
NSArray *constraintsEqualSize(id item1, id item2, CGFloat widthOffset, CGFloat heightOffset);
NSArray *constraintsEqualPosition(id item1, id item2, CGFloat xOffset, CGFloat yOffset);