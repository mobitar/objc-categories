//
//  CSSHelper.h
//
//  Created by Mo Bitar on 4/14/13.
//

#import "CSS.h"

#pragma mark Category

@interface UIView (CSS)
@property (nonatomic, copy) NSString *divID;
+ (id)newWithDivId:(NSString*)divID addToView:(UIView*)view;
+ (void)configureItem:(id)item withCocoaKey:(NSString*)cocoaKey value:(id)value parentItem:(id)parentItem;
- (void)stylizeWithCSSClass:(Class<CSS>)css;
- (void)stylizeItem:(UIView*)item withCSSClass:(Class<CSS>)css;
- (void)setHighlighted:(BOOL)highlighted;
- (BOOL)isHighlighted;
@end