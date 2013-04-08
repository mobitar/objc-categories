//
//  UIScreen+Utilities.h
//
//  Created by u16suzu on 13/04/05.
//

#import <UIKit/UIKit.h>
#import "UIScreen+Utilities.h"

@implementation UIScreen(Utilities)
+ (BOOL)is4inch
{
    CGSize screenSize = [[self mainScreen] bounds].size;
    return screenSize.width == 320.0 && screenSize.height == 568.0;
}
@end
