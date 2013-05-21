//
//  UIView+Autolayout.m
//  NoteClub
//
//  Created by Mo Bitar on 5/11/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UIView+Autolayout.h"

@implementation UIView (Autolayout)
- (NSLayoutConstraint*)constraintForAttribute:(NSLayoutAttribute)attribute {
    for(NSLayoutConstraint *constraint in self.constraints) {
        if(eql(constraint.firstItem, self)) {
            if(constraint.firstAttribute == attribute) {
                return constraint;
            }
        }
    }
    return nil;
}

- (NSLayoutConstraint*)constraintForItem:(id)item attribute:(NSLayoutAttribute)attribute {
    for(NSLayoutConstraint *constraint in self.constraints) {
        if(eql(constraint.firstItem, item)) {
            if(constraint.firstAttribute == attribute) {
                return constraint;
            }
        }
    }
    return nil;
}

- (BOOL)containsConstraint:(NSLayoutConstraint*)targetConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if(NSLayoutConstraintEqual(constraint, targetConstraint))
            return YES;
        
    }
    return NO;
}

- (void)removeAutoresizingConstraints {
    Class cls = NSClassFromString(@"NSAutoresizingMaskLayoutConstraint");
    for(NSLayoutConstraint *constraint in self.constraints) {
        if(is(constraint, cls)) {
            [self removeConstraint:constraint];
        }
    }
}

@end
