
//  Created by Mo Bitar on 1/18/13.

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

+ (NSDate*)dateFromString:(NSString*)dateString format:(NSString*)format timezone:(NSTimeZone*)timezone
{
    if(!dateString)
        return nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:timezone];
    return [formatter dateFromString:dateString];
}

+ (NSDate*)dateFromString:(NSString*)dateString format:(NSString*)format
{
    return [self dateFromString:dateString format:format timezone:[NSTimeZone timeZoneWithName:@"UTC"]];
}

- (NSString*)dateToString
{
    return [self dateToStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString*)dateToStringWithDateFormat:(NSString*)dateFormat
{
    return [self dateToStringWithDateFormat:dateFormat timezone:[NSTimeZone timeZoneWithName:@"UTC"]];
}

- (NSString*)dateToStringWithDateFormat:(NSString*)dateFormat timezone:(NSTimeZone*)timezone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    [formatter setTimeZone:timezone];
    return [formatter stringFromDate:self];
}

- (NSDate*)dateByStrippingTimeComponents {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:self];
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    NSDate *strippedDate = [gregorian dateFromComponents:dateComponents];
    return strippedDate;
}

- (NSDate*)dateByOffsettingMonths:(NSUInteger)months days:(NSUInteger)days hours:(NSUInteger)hours minutes:(NSUInteger)minutes seconds:(NSUInteger)seconds {
    NSDateComponents *components = [NSDateComponents new];
    NSCalendar *calender = [NSCalendar currentCalendar];
    components.month = months;
    components.day = days;
    components.hour = hours;
    components.minute = minutes;
    components.second = seconds;
    return [calender dateByAddingComponents:components toDate:self options:0];
}

- (NSString*)dateToFullFormString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    return [dateFormatter stringFromDate:self];
}

- (NSString*)dateToStringWithFormatterStyle:(NSDateFormatterStyle)style {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = style;
    return [dateFormatter stringFromDate:self];
}

+ (NSDate *)randomDateInYearOfDate {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [currentCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    int month = arc4random_uniform(12);
    [comps setMonth:month];
    [comps setDay:30];
    
    // Normalise the time portion
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    [comps setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [currentCalendar dateFromComponents:comps];
}

- (NSString*)stringWithHumanizedTimeDifference {
    
    NSTimeInterval timeInterval = [self timeIntervalSinceNow];
    
    int secondsInADay = 3600*24;
    int secondsInAYear = 3600*24*365;
    int yearsDiff = abs(timeInterval/secondsInAYear);
    int daysDiff = abs(timeInterval/secondsInADay);
    int hoursDiff = abs((abs(timeInterval) - (daysDiff * secondsInADay)) / 3600);
    int minutesDiff = abs((abs(timeInterval) - ((daysDiff * secondsInADay) + (hoursDiff * 60))) / 60);
    
    NSString *positivity = [NSString stringWithFormat:@"%@", NSLocalizedString(@"ago", @"")];
    
    if (yearsDiff > 1)
        return [NSString stringWithFormat:@"%d %@ %@", yearsDiff, NSLocalizedString(@"years", @""), positivity];
    else if (yearsDiff == 1)
        return [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"a year", @""), positivity];
    
    if (daysDiff > 0) {
        if (hoursDiff == 0)
            return [NSString stringWithFormat:@"%d %@ %@", daysDiff, daysDiff == 1 ? NSLocalizedString(@"day", @""):NSLocalizedString(@"days", @""), positivity];
        else
            return [NSString stringWithFormat:@"%d %@ %@", daysDiff, daysDiff == 1 ? NSLocalizedString(@"day", @""):NSLocalizedString(@"days", @""), positivity];
    }
    else {
        if (hoursDiff == 0) {
            if (minutesDiff == 0)
                return [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"a few seconds", @""), positivity];
            else
                return [NSString stringWithFormat:@"%d %@ %@", minutesDiff, minutesDiff == 1 ? NSLocalizedString(@"minute", @""):NSLocalizedString(@"minutes", @""), positivity];
        }
        else {
            if (hoursDiff == 1)
                return [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"about", @""), NSLocalizedString(@"an hour", @""), positivity];
            else
                return [NSString stringWithFormat:@"%d %@ %@", hoursDiff, NSLocalizedString(@"hours", @""), positivity];
        }
    }
}
@end
