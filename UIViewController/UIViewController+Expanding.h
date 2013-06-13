//
//  UIViewController+Expanding.h
//  Grid
//
//  Created by Mo Bitar on 4/30/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Expanding)
- (void)presentExpandingViewController:(UIViewController*)controller origin:(CGPoint)origin anchorPoint:(CGPoint)anchorPoint;
- (void)dismissExpandingViewController;
- (void)dismissExpandingViewController:(UIViewController*)controller;
- (UIViewController*)expandingViewController;
@end
