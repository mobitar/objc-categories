//
//  CSSKeyPath.h
//  Grid
//
//  Created by Mo Bitar on 4/29/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSSKeyPath : NSObject
@property (nonatomic, copy) NSString *keypath;
CSSKeyPath *CSSKeyPathMake(NSString *keypath);
@end
