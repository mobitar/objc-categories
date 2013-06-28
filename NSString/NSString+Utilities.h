
#import <Foundation/Foundation.h>

@interface NSString (Utilities)
- (BOOL)contains:(NSString*)string;
- (NSString*)add:(NSString*)string;
- (BOOL)isValidEmail;
- (NSDictionary*)firstAndLastName;
@end
