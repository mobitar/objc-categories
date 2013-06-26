#import "VTPG_Common.h"
/*
 * creates a formatted string
 * usage: $str(@"My number:%i", 5);
 */
#define str(...) [NSString stringWithFormat:__VA_ARGS__]

/*
 * returns an image with given name
 * usage: $img(@"myImage.png");
 */
#define img(name) [UIImage imageNamed:name]

/*
 * checks if two objects are equal
 * usage: if($eql(var1, var2))...
 */
#define eql(obj1, obj2) [obj1 isEqual:obj2]

/*
 * returns if both objects are equal
 * (used primarily in setter methods)
 * usage: if($return_if_eql(var1, var2))...
 */
#define $return_if_equal(obj1, obj2) \
    if(eql(obj1, obj2)) return

/*
 * checks if the instance is of type cls
 * usage: if($is(val, UIFont))...
 */
#define is(instance, cls) [instance isKindOfClass:[cls class]]

/*
 * creates a local variable named varname of type cls
 * usage: $new(NSArray, myArray)
 * int count = myArray.count;
 */
#define local(cls, varname) cls *varname = [cls new]

/*
 usage: self.label = $create(UILabel)
 */
#define $create(cls) [cls new]

/*
 * creates a local "weakself" variable
 * usage: @createWeakSelf
 */
#define createWeakSelf try {} @finally {} __weak typeof(self) weakself = self;

/*
 * replaces occurences of find value in string with replace value
 * usage: $stringreplace(myString, @"cat", @"dog") 
 */
#define $stringreplace(string, find, replace) [string stringByReplacingOccurrencesOfString:find withString:replace];

#define $stringify(var) # var

#define predicate(...) [NSPredicate predicateWithFormat:__VA_ARGS__]

#define Init(input)          \
    - (id)init {                  \
        if(self = [super init]) { \
            input                 \
        }                         \
        return self;              \
}

#define indexpath(row, section) [NSIndexPath indexPathForRow:row inSection:section]