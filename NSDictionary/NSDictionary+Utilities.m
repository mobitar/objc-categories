
#import "NSDictionary+Utilities.h"

@implementation NSDictionary (Utilities)
+ (instancetype)dictionaryFromJSONString:(NSString*)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error) {
        return nil;
    }
    return dictionary;
}
@end
