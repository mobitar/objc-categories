//
//  NSNumber+Utilities.m
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "NSNumber+Utilities.h"

@implementation NSNumber (Utilities)
- (void)delayedPerform:(void(^)())block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.floatValue * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        block();
    });
}

- (void)animate:(void(^)())block {
    [UIView animateWithDuration:self.floatValue animations:block];
}
@end
