//
//  UIViewController+Utilities.m
//  nubhub
//
//  Created by Bitar on 3/18/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UIViewController+Utilities.h"

@implementation UIViewController (Utilities)
- (void)addViewControllerToViewHeirarchy:(UIViewController*)controller {
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

- (void)addViewControllerToHeirarchy:(UIViewController*)controller addToView:(UIView*)view {
    [self addChildViewController:controller];
    [view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

- (void)addViewControllerToHeirarchy:(UIViewController *)controller addSubview:(UIView*)subView toView:(UIView*)view {
    [self addChildViewController:controller];
    [view addSubview:subView];
    [controller didMoveToParentViewController:self];
}

- (void)loadViewWithDefaultSize {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, window.bounds.size.width, window.bounds.size.height - statusBarRect.size.height)];
}
@end
