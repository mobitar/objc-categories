
#import <Foundation/Foundation.h>

@interface NSArray (Utilities)
- (instancetype)arrayWithUniqueObjects;
- (id)safeObjectAtIndex:(NSInteger)index;
- (instancetype)safeSubArrayWithRange:(NSRange)range;
- (NSString*)toJSON;
@end
