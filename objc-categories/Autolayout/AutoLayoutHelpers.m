//
//  AutoLayoutHelpers.m
//
//  Created by Mo Bitar on 5/8/13.
//

#import "AutoLayoutHelpers.h"

NSLayoutConstraint *constraintEqual(id item1, id item2, NSLayoutAttribute attribute, CGFloat offset) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:attribute relatedBy:NSLayoutRelationEqual toItem:item2 attribute:attribute multiplier:1.0 constant:offset];
}

NSLayoutConstraint *constraintEqualAttributes(id item1, id item2, NSLayoutAttribute attribute1, NSLayoutAttribute attribute2, CGFloat offset) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:attribute1 relatedBy:NSLayoutRelationEqual toItem:item2 attribute:attribute2 multiplier:1.0 constant:offset];
}

NSLayoutConstraint *constraintEqualWithMultiplier(id item1, id item2, NSLayoutAttribute attribute, CGFloat offset, CGFloat multiplier) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:attribute relatedBy:NSLayoutRelationEqual toItem:item2 attribute:attribute multiplier:multiplier constant:offset];
}

NSLayoutConstraint *constraintEqualAttributesWithMultiplier(id item1, id item2, NSLayoutAttribute attribute1, NSLayoutAttribute attribute2, CGFloat offset, CGFloat multiplier) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:attribute1 relatedBy:NSLayoutRelationEqual toItem:item2 attribute:attribute2 multiplier:multiplier constant:offset];
}

NSLayoutConstraint *constraintWidth(id item1, id item2, CGFloat offset) {
     return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:offset];
}

NSArray *constraintsCenter(id item, id centerTo) {
    NSLayoutConstraint *horizontal = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:centerTo attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *vertical = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:centerTo attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    return @[horizontal, vertical];
}

NSArray *constraintsCenterWithOffset(id item, id centerTo, CGFloat xOffset, CGFloat yOffset) {
    NSLayoutConstraint *horizontal = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:centerTo attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:xOffset];
    NSLayoutConstraint *vertical = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:centerTo attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:yOffset];
    return @[horizontal, vertical];
}

NSLayoutConstraint *constraintCenterX(id item1, id item2) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
}

NSLayoutConstraint *constraintCenterY(id item1, id item2) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
}

NSLayoutConstraint *constraintTrailVertically(id item1, id item2, CGFloat offset) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:offset];
}

NSLayoutConstraint *constraintHeight(id item1, id item2, CGFloat offset) {
    NSLayoutAttribute secondAttribute = item2 ? NSLayoutAttributeHeight : NSLayoutAttributeNotAnAttribute;
    return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:item2 attribute:secondAttribute multiplier:1.0 constant:offset];
}

NSLayoutConstraint *constraintTop(id item1, id item2, CGFloat offset) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeTop multiplier:1.0 constant:offset];
}

NSLayoutConstraint *constraintBottom(id item1, id item2, CGFloat offset) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:offset];
}

NSLayoutConstraint *constraintLeft(id item1, id item2, CGFloat offset) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:offset];
}

NSLayoutConstraint *constraintRight(id item1, id item2, CGFloat offset) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeRight multiplier:1.0 constant:offset];
}

NSLayoutConstraint *constraintAbsolute(id item1, NSLayoutAttribute attribute, CGFloat offset) {
    return [NSLayoutConstraint constraintWithItem:item1 attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:offset];
}

NSArray *constraintsAbsoluteSize(id item, CGFloat width, CGFloat height) {
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    return @[widthConstraint, heightConstraint];
}

NSArray *constraintsEqualSize(id item1, id item2, CGFloat widthOffset, CGFloat heightOffset) {
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:item2 attribute:item2 ? NSLayoutAttributeWidth : NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:widthOffset];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:item2 attribute:item2 ? NSLayoutAttributeHeight : NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:heightOffset];
    return @[width, height];
}

NSArray *constraintsEqualPosition(id item1, id item2, CGFloat xOffset, CGFloat yOffset) {
    NSLayoutConstraint *x = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:xOffset];
    NSLayoutConstraint *y = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeTop multiplier:1.0 constant:yOffset];
    return @[x, y];
}
