// Categories.h

#import "NSObject+Utilities.h"
#import "UIView+Utilities.h"
#import "UIViewController+Utilities.h"
#import "NSFetchedResultsController+Utilities.h"
#import "UIScrollView+Utilities.h"
#import "NSTimer+Blocks.h"
#import "EXTRuntimeExtensions.h"
#import "VTPG_Common.h"

#define underize(name) _##name

#define property_type(property)                                \
    property_attr(property)->objectClass

#define property_attr(propertyName)                            \
    ext_copyPropertyAttributes(class_getProperty(self.class, # propertyName))

#define default_init(propertyName)                             \
    - (id)propertyName {                                       \
    if(!underize(propertyName))                                \
        self.propertyName = [property_type(propertyName) new]; \
    return underize(propertyName);                             \
}

#define $str(...) [NSString stringWithFormat:__VA_ARGS__]

#define $img(name) [UIImage imageNamed:name]

#define $eql(obj1, obj2) [obj1 isEqual:obj2]

#define return_if_equal(obj1, obj2) \
    if($eql(obj1, obj2)) return