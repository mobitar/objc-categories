//
//  NSDate+Utilities.h
//
//  Created by Mo Bitar on 1/18/13.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utilities)
- (NSString*)stringWithHumanizedTimeDifference;
- (NSString*)dateToString;
- (NSString*)dateToStringWithFormatterStyle:(NSDateFormatterStyle)style ;
- (NSString*)dateToStringWithDateFormat:(NSString*)dateFormat;
- (NSDate*)dateByStrippingTimeComponents;
- (NSString*)dateToFullFormString;
+ (NSDate*)randomDateInYearOfDate;
@end
