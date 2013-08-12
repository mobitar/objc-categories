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
- (void)shiftVerticallyBy:(CGFloat)offset;
- (void)shiftHorizontallyBy:(CGFloat)offset;
- (void)offsetSizeBy:(CGSize)size;
- (void)centerWithRespectToView:(UIView*)view;
- (void)centerVerticallyWithRespectToView:(UIView*)view;
- (void)centerHorizontallyWithRespectToView:(UIView*)view;

// layout
- (void)layoutViews:(NSArray*)views startingAt:(CGPoint)origin margins:(NSArray*)margins centerHorizontally:(BOOL)centerHorizontally centerVertically:(BOOL)centerVertically;
- (CGFloat)originYIfToBeCenteredInSuperview;
- (void)centerWithRespectToView:(UIView*)view offset:(CGSize)offset horizontally:(BOOL)horizontally vertically:(BOOL)vertically;
- (void)centerViews:(NSArray*)views withRespectToView:(UIView*)view;
- (void)centerViewsVertically:(NSArray*)views spacing:(CGFloat)space;
- (void)centerViewsVertically:(NSArray*)views spacing:(CGFloat)space inContentArea:(CGRect)area;
+ (void)centerViewHorizontally:(UIView*)view inContentAreaStartingAt:(CGPoint)origin size:(CGSize)size;
+ (void)swapPositionOfView:(UIView*)firstView withView:(UIView*)secondView animated:(BOOL)animated;
- (void)trailVerticallyTo:(UIView*)trailTo;
- (void)trailVerticallyTo:(UIView*)trailTo offset:(CGFloat)offset;
- (void)trailHorizontallyTo:(UIView*)trailTo offset:(CGFloat)offset;
- (void)alignLeftEdgeTo:(UIView*)view;

// beauty
- (CAGradientLayer*)addGradientWithColors:(NSArray*)colors locations:(NSArray*)locations vertical:(BOOL)vertical;
- (void)addBorderWithColor:(UIColor*)color width:(CGFloat)width;
- (void)addShadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;

// animation
- (void)animateUpFromBottomOfSuperviewWithDuration:(CGFloat)duration;

// info
- (CGSize)size;
- (CGPoint)origin;
- (CGFloat)frameEndX;
- (CGPoint)frameEndPoint;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)yOrigin;
- (CGFloat)xOrigin;
- (CGFloat)maxY;
- (CGFloat)maxX;

// utilities
- (void)resignFirstRespondersRecursively;
- (id)viewFromNibNamed:(NSString*)name;
@end
