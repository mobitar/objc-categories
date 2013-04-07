//
//  MBAnimationSequencer
//  Bitar
//
//  Created by Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Utilities)

NSValue *valueWithSize(CGFloat width, CGFloat height);
NSValue *valueWithPoint(CGPoint p);

// frame operations
- (void)setXOrigin:(CGFloat)x;
- (void)setYOrigin:(CGFloat)y;
- (void)setOrigin:(CGPoint)origin;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)origin size:(CGSize)size;
- (void)shiftBy:(CGSize)shift;
- (void)offsetSizeBy:(CGSize)size;
- (void)centerWithRespectToView:(UIView*)view;
- (void)centerVerticallyWithRespectToView:(UIView*)view;
- (void)centerHorizontallyWithRespectToView:(UIView*)view;


- (void)layoutViews:(NSArray*)views startingAt:(CGPoint)origin margins:(NSArray*)margins centerHorizontally:(BOOL)centerHorizontally centerVertically:(BOOL)centerVertically;
- (CGFloat)originYIfToBeCenteredInSuperview;
- (void)centerWithRespectToView:(UIView*)view offset:(CGSize)offset horizontally:(BOOL)horizontally vertically:(BOOL)vertically;
- (void)centerViews:(NSArray*)views withRespectToView:(UIView*)view;
+ (void)centerViewHorizontally:(UIView*)view inContentAreaStartingAt:(CGPoint)origin size:(CGSize)size;

// beauty
- (CAGradientLayer*)addGradientWithColors:(NSArray*)colors locations:(NSArray*)locations vertical:(BOOL)vertical;
- (void)addBorderWithColor:(UIColor*)color width:(CGFloat)width;
- (void)addShadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;

// info
- (CGSize)size;
- (CGPoint)origin;
- (CGFloat)frameEndX;
- (CGPoint)frameEndPoint;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)yOrigin;
- (CGFloat)yOriginPlusHeight;
- (CGFloat)xOriginPlusWidth;

// utilities
- (void)resignFirstRespondersRecursively;
- (UIView*)viewFromNibNamed:(NSString*)name;
@end
