
#import <Foundation/Foundation.h>

@interface NSString (Utilities)
- (BOOL)contains:(NSString*)string;
- (NSString*)add:(NSString*)string;
- (NSDictionary*)firstAndLastName;
- (BOOL)isValidEmail;
- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
@end
