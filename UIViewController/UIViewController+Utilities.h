//
//  UIViewController+Utilities.h
//  nubhub
//
//  Created by Bitar on 3/18/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utilities)
- (void)addViewControllerToViewHeirarchy:(UIViewController*)controller;
- (void)addViewControllerToHeirarchy:(UIViewController*)controller addToView:(UIView*)view;
- (void)addViewControllerToHeirarchy:(UIViewController *)controller addSubview:(UIView*)subView toView:(UIView*)view;
- (void)loadViewWithDefaultSize;
@end
