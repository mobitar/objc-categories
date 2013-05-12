//
//  NSNumber+Utilities.h
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Utilities)
- (void)delayedPerform:(void(^)())block;
- (void)animate:(void(^)())block;
@end
