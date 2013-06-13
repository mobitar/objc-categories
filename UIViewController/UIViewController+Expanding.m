//
//  UIViewController+Expanding.m
//  Grid
//
//  Created by Mo Bitar on 4/30/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UIViewController+Expanding.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation UIViewController (Expanding)

#define ExpandingAnimationKey @"expandingAnimation"
#define RemoveExpandingKey @"removeExpandingAnimation"

- (void)presentExpandingViewController:(UIViewController*)controller origin:(CGPoint)origin anchorPoint:(CGPoint)anchorPoint {
    [self addChildViewController:controller];
    
    CATransform3D const initialTransform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    CALayer *layer = controller.view.layer;
    [layer removeAnimationForKey:RemoveExpandingKey];
    layer.anchorPoint = anchorPoint;
    
    CGRect frame = controller.view.frame;
    frame.origin = origin;
    controller.view.frame = frame;
    
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    
    [self setExpandingViewController:controller];
    
    // animate
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.keyTimes = @[@0, @1];
    animation.values = @[
                         [NSValue valueWithCATransform3D:initialTransform],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                         ];
    animation.duration = 0.20;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [layer addAnimation:animation forKey:@"ExpandingAnimationKey"];
}

- (void)dismissExpandingViewController {
    UIViewController *controller = [self expandingViewController];
    [self dismissExpandingViewController:controller];
}

- (void)dismissExpandingViewController:(UIViewController*)controller {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.keyTimes = @[@0, @1];
    animation.values = @[
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
                         ];
    animation.duration = 0.20;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [controller.view.layer addAnimation:animation forKey:RemoveExpandingKey];

    self.expandingViewController = nil;
    

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation.duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [controller removeFromParentViewController];
        [controller.view removeFromSuperview];
    });
}

static NSString *ExpandingViewController = @"ExpandingViewController";

- (void)setExpandingViewController:(UIViewController*)controller {
    objc_setAssociatedObject(self, &ExpandingViewController, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController*)expandingViewController {
    return objc_getAssociatedObject(self, &ExpandingViewController);
}
@end
