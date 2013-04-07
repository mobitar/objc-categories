// Categories.h

#import "NSObject+Utilities.h"
#import "UIView+Utilities.h"
#import "UIViewController+Utilities.h"
#import "NSFetchedResultsController+Utilities.h"
#import "UIScrollView+Utilities.h"
#import "NSTimer+Blocks.h"
#import "VTPG_Common.h"

#define $str(...) [NSString stringWithFormat:__VA_ARGS__]

#define $img(name) [UIImage imageNamed:name]

#define $eql(obj1, obj2) [obj1 isEqual:obj2]

#define return_if_equal(obj1, obj2) \
    if($eql(obj1, obj2)) return