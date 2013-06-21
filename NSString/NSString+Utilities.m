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

#define MaxEmailLength 254
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL validEmail = [emailTest evaluateWithObject:self];
    if(validEmail && self.length <= MaxEmailLength)
        return YES;
    return NO;
}

- (NSString*)add:(NSString*)string
{
    return [self stringByAppendingString:string];
}
@end
