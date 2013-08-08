
#import "NSString+Utilities.h"

@implementation NSString (Utilities)
- (BOOL)contains:(NSString*)string {
    return [self rangeOfString:string].location != NSNotFound;
}

#define MaxEmailLength 254
- (BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL validEmail = [emailTest evaluateWithObject:self];
    if(validEmail && self.length <= MaxEmailLength)
        return YES;
    return NO;
}

- (NSString*)add:(NSString*)string
{
    if(!string || string.length == 0)
        return self;
    return [self stringByAppendingString:string];
}

- (NSDictionary*)firstAndLastName
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSArray *comps = [self componentsSeparatedByString:@" "];
    if(comps.count > 0) dic[@"firstName"] = comps[0];
    if(comps.count > 1) dic[@"lastName"] = comps[1];
    return dic;
}

- (BOOL)containsOnlyLetters
{
    NSCharacterSet *blockedCharacters = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbers = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbers].location == NSNotFound);
}

- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

- (NSString*)safeSubstringToIndex:(NSUInteger)index
{
    if(index >= self.length)
        index = self.length - 1;
    return [self substringToIndex:index];
}

- (NSString*)stringByRemovingPrefix:(NSString*)prefix
{
    NSRange range = [self rangeOfString:prefix];
    if(range.location == 0) {
        return [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

- (NSString*)stringByRemovingPrefixes:(NSArray*)prefixes
{
    for(NSString *prefix in prefixes) {
        NSRange range = [self rangeOfString:prefix];
        if(range.location == 0) {
            return [self stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    return self;
}

- (BOOL)hasPrefixes:(NSArray*)prefixes
{
    for(NSString *prefix in prefixes) {
        if([self hasPrefix:prefix])
            return YES;
    }
    return NO;
}

- (BOOL)isEqualToOneOf:(NSArray*)strings
{
    for(NSString *string in strings) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}
@end
