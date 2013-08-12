//
//  UIView+Utilities.m
//  nubhub
//
//  Created by Bitar on 3/18/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

#pragma mark Frame Operations

- (void)setXOrigin:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setYOrigin:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin size:(CGSize)size {
    CGRect frame = self.frame;
    frame.origin = origin, frame.size = size;
    self.frame = frame;
}

- (void)shiftBy:(CGSize)shift {
    CGRect frame = self.frame;
    frame.origin.x += shift.width;
    frame.origin.y += shift.height;
    self.frame = frame;
}

- (void)shiftVerticallyBy:(CGFloat)offset
{
    [self shiftBy:CGSizeMake(0, offset)];
}

- (void)shiftHorizontallyBy:(CGFloat)offset
{
    [self shiftBy:CGSizeMake(offset, 0)];
}

- (void)offsetSizeBy:(CGSize)size {
    CGRect frame = self.frame;
    frame.size.width += size.width;
    frame.size.height += size.height;
    self.frame = frame;
}

- (void)centerWithRespectToView:(UIView*)view {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(view.bounds.size.width/2.0 - frame.size.width/2.0, view.bounds.size.height/2.0 - frame.size.height/2.0);
    self.frame = frame;
}

- (void)centerHorizontallyWithRespectToView:(UIView*)view {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(view.bounds.size.width/2.0 - frame.size.width/2.0, frame.origin.y);
    self.frame = frame;
}

- (void)centerVerticallyWithRespectToView:(UIView*)view {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(frame.origin.x, view.bounds.size.height/2.0 - frame.size.height/2.0);
    self.frame = frame;
}


NSValue *valueWithSize(CGFloat width, CGFloat height) {
    return [NSValue valueWithCGSize:CGSizeMake(width, height)];
}

NSValue *valueWithPoint(CGPoint p) {
    return [NSValue valueWithCGPoint:p];
}

- (void)layoutViews:(NSArray*)views startingAt:(CGPoint)origin margins:(NSArray*)margins centerHorizontally:(BOOL)centerHorizontally centerVertically:(BOOL)centerVertically {
    __block CGPoint currentOrigin = origin;
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger index, BOOL *stop) {
        CGPoint thisOrigin = currentOrigin;
        if(centerVertically) {
            thisOrigin.y = view.superview.height/2.0 - view.height/2.0;
        }
        if(centerHorizontally) {
            thisOrigin.x = view.superview.width/2.0 - view.width/2.0;
        }
        CGSize currentMargin = [margins[index] CGSizeValue];
        
        CGFloat x = centerHorizontally ? thisOrigin.x : currentOrigin.x;
        CGFloat y = centerVertically ? thisOrigin.y : currentOrigin.y;
        
        [view setOrigin:CGPointMake(x + currentMargin.width, y + currentMargin.height)];
        currentOrigin.x = view.origin.x + view.size.width;
        currentOrigin.y = view.origin.y + view.size.height;
    }];
}

- (CGFloat)originYIfToBeCenteredInSuperview {
    return self.superview.height/2.0 - self.height/2.0;
}

- (void)centerWithRespectToView:(UIView*)view offset:(CGSize)offset horizontally:(BOOL)horizontally vertically:(BOOL)vertically {
    CGRect frame = self.frame;
    if(horizontally)
        frame.origin.x = view.bounds.size.width/2.0 - frame.size.width/2.0 + offset.width;
    if(vertically)
        frame.origin.y = view.bounds.size.height/2.0 - frame.size.height/2.0 + offset.height;
    self.frame = frame;
}

- (void)centerViewsVertically:(NSArray*)views spacing:(CGFloat)space
{
    CGFloat totalHeight = [self heightForViews:views withVerticalSpacing:space];
    
    CGFloat y = self.height/2.0 - totalHeight/2.0;
    for(UIView *view in views) {
        [view setYOrigin:y];
        y += view.height + space;
    }
}

- (void)centerViewsVertically:(NSArray*)views spacing:(CGFloat)space inContentArea:(CGRect)area
{
    CGFloat totalHeight = [self heightForViews:views withVerticalSpacing:space];
   
    CGFloat y = area.origin.y + area.size.height/2.0 - totalHeight/2.0;
    for(UIView *view in views) {
        [view setYOrigin:y];
        y += view.height + space;
    }
}

- (CGFloat)heightForViews:(NSArray*)views withVerticalSpacing:(CGFloat)spacing
{
    CGFloat totalHeight = 0;
    NSInteger counter = 0;
    for(UIView *view in views) {
        totalHeight += view.height;
        if(counter != 0 && counter != views.count - 1)
            totalHeight += spacing;
        counter++;
    }
    return totalHeight;
}

- (void)centerViews:(NSArray*)views withRespectToView:(UIView*)view {
    for(UIView *view in views) {
        [view centerWithRespectToView:view];
    }
}

+ (void)centerViewHorizontally:(UIView*)view inContentAreaStartingAt:(CGPoint)origin size:(CGSize)size {
    CGRect frame = view.frame;
    frame.origin.x = origin.x + size.width/2.0 - frame.size.width/2.0;
    view.frame = frame;
}

+ (void)swapPositionOfView:(UIView*)firstView withView:(UIView*)secondView animated:(BOOL)animated {
    CGPoint firstFinalOrigin = secondView.layer.position;
    CGPoint secondFinalOrigin = firstView.layer.position;
    
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        firstView.layer.position = firstFinalOrigin;
        secondView.layer.position = secondFinalOrigin;
    }];
}

- (void)trailVerticallyTo:(UIView*)trailTo {
    [self setYOrigin:trailTo.maxY];
}

- (void)trailVerticallyTo:(UIView*)trailTo offset:(CGFloat)offset
{
    [self setYOrigin:trailTo.maxY + offset];
}

- (void)trailHorizontallyTo:(UIView*)trailTo offset:(CGFloat)offset
{
    [self setXOrigin:trailTo.maxX + offset];
}

- (void)alignLeftEdgeTo:(UIView*)view
{
    [self setXOrigin:view.xOrigin];
}

#pragma mark - Info

- (CGSize)size {
    return self.bounds.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)frameEndX {
    return self.frame.origin.x + self.width;
}

- (CGPoint)frameEndPoint {
    return CGPointMake(self.frame.origin.x + self.width, self.frame.origin.y + self.height);
}

- (CGFloat)width {
    return self.bounds.size.width;
}

- (CGFloat)height {
    return self.bounds.size.height;
}

- (CGFloat)xOrigin {
    return self.frame.origin.x;
}

- (CGFloat)yOrigin {
    return self.frame.origin.y;
}

- (CGFloat)maxY {
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

- (CGFloat)maxX {
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}

#pragma mark Beauty

- (CAGradientLayer*)addGradientWithColors:(NSArray*)colors locations:(NSArray*)locations vertical:(BOOL)vertical {
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = self.bounds;
    grad.locations = locations;
    grad.colors = colors;
    if(! vertical) {
        grad.startPoint = CGPointMake(0, 0.5);
        grad.endPoint = CGPointMake(1, 0.5);
    }
    [self.layer addSublayer:grad];
    return grad;
}

- (void)addBorderWithColor:(UIColor*)color width:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)addShadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark - Animations

- (void)animateUpFromBottomOfSuperviewWithDuration:(CGFloat)duration {
    [self animateFromPoint:CGPointMake(self.origin.x, self.superview.height) to:CGPointMake(self.origin.x, self.superview.height - self.height) duration:duration];
}

- (void)animateFromPoint:(CGPoint)from to:(CGPoint)to duration:(CGFloat)duration {
    self.origin = from;
    [UIView animateWithDuration:duration animations:^{
        self.origin = to;
    }];
}

#pragma mark Utilities

- (void)resignFirstRespondersRecursively {
    [self resignFirstResponderForSubviewsOfView:self];
}

- (void)resignFirstResponderForSubviewsOfView:(UIView *)aView {
    for (UIView *subview in [aView subviews]) {
        if ([subview isKindOfClass:[UITextField class]] || [subview isKindOfClass:[UITextView class]])
            [(id)subview resignFirstResponder];
        [self resignFirstResponderForSubviewsOfView:subview];
    }
}

- (id)viewFromNibNamed:(NSString*)name {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
    return [topLevelObjects objectAtIndex:0];
}
@end
