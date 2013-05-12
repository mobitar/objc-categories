//
//  NSString+Utilities.m
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)
- (BOOL)contains:(NSString*)string {
    return [self rangeOfString:string].location != NSNotFound;
}
@end
