//
//  UIView+Autolayout.h
//  NoteClub
//
//  Created by Mo Bitar on 5/11/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Autolayout)
- (NSLayoutConstraint*)constraintForAttribute:(NSLayoutAttribute)attribute;
- (NSLayoutConstraint*)constraintForItem:(id)item attribute:(NSLayoutAttribute)attribute;
@end
