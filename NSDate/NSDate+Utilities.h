
//  Created by Mo Bitar on 1/18/13.

#import <Foundation/Foundation.h>

@interface NSDate (Utilities)
+ (NSDate*)dateFromString:(NSString*)dateString format:(NSString*)format;
+ (NSDate*)dateFromString:(NSString*)dateString format:(NSString*)format timezone:(NSTimeZone*)timezone;
- (NSString*)stringWithHumanizedTimeDifference;
- (NSString*)dateToString;
- (NSString*)dateToStringWithFormatterStyle:(NSDateFormatterStyle)style;
- (NSString*)dateToStringWithDateFormat:(NSString*)dateFormat;
- (NSString*)dateToStringWithDateFormat:(NSString*)dateFormat timezone:(NSTimeZone*)timezone;
- (NSDate*)dateByOffsettingMonths:(NSUInteger)months days:(NSUInteger)days
           hours:(NSUInteger)hours minutes:(NSUInteger)minutes seconds:(NSUInteger)seconds;
- (NSDate*)dateByStrippingTimeComponents;
- (NSString*)dateToFullFormString;
+ (NSDate*)randomDateInYearOfDate;
@end
