
#import "NSDictionary+Utilities.h"

@implementation NSDictionary (Utilities)
+ (instancetype)dictionaryFromJSONString:(NSString*)string
{
    if(!string || string.length == 0)
        return nil;
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error) {
        return nil;
    }
    return dictionary;
}
@end
