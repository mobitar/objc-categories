
#import "UIAlertView+Utilities.h"

@implementation UIAlertView (Utilities)
+ (void)showAlertWithTitle:(NSString*)title desc:(NSString*)desc cancelTitle:(NSString*)cancelTitle
{
    [[[UIAlertView alloc] initWithTitle:title message:desc delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil] show];
}
@end
