
#import "NSArray+Utilities.h"

@implementation NSArray (Utilities)
- (instancetype)arrayWithUniqueObjects
{
    NSMutableArray *uniqueObjects = [NSMutableArray new];
    for(id obj in self) {
        if([uniqueObjects containsObject:obj] == NO) {
            [uniqueObjects addObject:obj];
        }
    }
    return uniqueObjects;
}

- (id)safeObjectAtIndex:(NSInteger)index
{
    if(index >= self.count)
        return nil;
    return self[index];
}
@end
