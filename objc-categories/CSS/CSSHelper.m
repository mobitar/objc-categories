//
//  CSSHelper.m
//  Grid
//
//  Created by Mo Bitar on 4/14/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "CSSHelper.h"
#import <objc/runtime.h>
#import "EXTRuntimeExtensions.h"
#import "NoteViewCSS.h"

@implementation CSSHelper
+ (NSDictionary*)CSStoUIKITMapping {
    return @{
             @(CSSColor)             : @"textColor",
             @(CSSBackgroundColor)   : @"backgroundColor",
             @(CSSFont)              : @"font",
             @(CSSTextAlignment)     : @"textAlignment",
             @(CSSVerticalAlignment) : @"contentVerticalAlignment",
             @(CSSOpacity)           : @"alpha",
             @(CSSShadowOffset)      : @"shadowOffset",
             @(CSSShadowColor)       : @"shadowColor",
             @(CSSNumberOfLines)     : @"numberOfLines",
             @(CSSImage)             : @"image",
             };
}

- (id)valueForProperty:(CSSProperty)property fromClass:(Class<CSS>)css forDivId:(NSString*)id {
    NSDictionary *properties = [css mainProperties];
    return properties[@(property)];
}

@end

#pragma mark --
#pragma mark - CSS Categories


@implementation NSObject (CSS)

- (void)stylizeWithCSSClass:(Class)css {
    NSDictionary *mapping = [CSSHelper CSStoUIKITMapping];
    if([css respondsToSelector:@selector(mainProperties)]) {
        NSDictionary *properties = [self.class propertiesForDiv:@"mainProperties" item:self fromClass:css];
        [CSSHelper stylizeItem:self withProperties:properties mapping:mapping parentItem:nil];
    }
    
    unsigned propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &propertyCount);
    
    [self configureSuperviewsForProperties:properties count:propertyCount css:css];
    
    for (unsigned i = 0; i < propertyCount; ++i) {
        objc_property_t prop = properties[i];
        NSString *propertyName = str(@"%s", property_getName(prop));
    
        id item = [self valueForKey:propertyName];
        if([item divID])
            propertyName = [item divID];
        if(item) {
            NSDictionary *properties = [self.class propertiesForDiv:propertyName item:item fromClass:css];
            [self.class stylizeItem:item withProperties:properties mapping:mapping parentItem:self];
        }
    }
}

- (void)configureSuperviewsForProperties:(objc_property_t *)properties count:(unsigned)propertyCount css:(Class)css {
    for (unsigned i = 0; i < propertyCount; ++i) {
        objc_property_t prop = properties[i];
        NSString *propertyName = str(@"%s", property_getName(prop));
        id view = [self valueForKey:propertyName];
        if([view divID])
            propertyName = [view divID];
        
        ext_propertyAttributes attributes = *ext_copyPropertyAttributes(prop);
        if(!view) {
            view = attributes.objectClass.new;
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if(properties)
                [self performSelector:attributes.setter withObject:view];
#pragma clang diagnostic pop
        }
        
        id targetView = is(self, UIViewController) ? [(id)self view] : self, targetSubview = view;
        
        NSDictionary *properties = [self.class propertiesForDiv:propertyName item:view fromClass:css];

        // by default we'll add a view controller's view property, but you can specify a custom subview such as tableView or collectionView with this:
        if(properties[@(CSSWhichSubview)]) {
            NSString *subviewKeyPath = properties[@(CSSWhichSubview)];
            targetSubview = [view valueForKeyPath:subviewKeyPath];
        }
    
        if([targetSubview isKindOfClass:[UIView class]] && ![targetSubview superview]) {
            if(properties[@(CSSSuperview)]) {
                NSString *superviewKeyPath = properties[@(CSSSuperview)];
                if(eql(superviewKeyPath, @"self") == NO) {
                    targetView = [self valueForKeyPath:superviewKeyPath];
                }
            }

            [targetView addSubview:targetSubview];
        }
        
        if([view respondsToSelector:@selector(setTranslatesAutoresizingMaskIntoConstraints:)]) {
            if(properties[@(CSSHasDefaultConstraints)]) {
                BOOL hasDefaultConstraints = [properties[@(CSSHasDefaultConstraints)] boolValue];
                [view setTranslatesAutoresizingMaskIntoConstraints:hasDefaultConstraints];
            } else {
                [view setTranslatesAutoresizingMaskIntoConstraints:NO];
            }
        }
    }
}

- (void)stylizeItem:(id)item divKey:(NSString*)key withCSSClass:(Class<CSS>)css {
    [CSSHelper stylizeItem:item withProperties:[self.class propertiesForDiv:key item:item fromClass:css] mapping:[CSSHelper CSStoUIKITMapping] parentItem:self];
}

+ (NSDictionary*)propertiesForDiv:(NSString*)div item:(id)item fromClass:(Class)css {
    id(^getPropertiesBlock)(Class, NSString *) =  ^id(Class cls, NSString* selectorString){
        SEL selector = NSSelectorFromString(selectorString);
        if(![cls respondsToSelector:selector]) {
            return nil;
        }
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[cls methodSignatureForSelector:selector]];
        invocation.target = cls;
        invocation.selector = selector;
        [invocation invoke];
        
        __unsafe_unretained id val = nil;
        [invocation getReturnValue:&val];
        return val;
    };
    
    BOOL highlighted = NO;
    NSString *selectorString = div;
    if([item respondsToSelector:@selector(isHighlighted)]) {
        if([item isHighlighted]) {
            selectorString = [selectorString stringByAppendingString:@"_highlighted"];
            highlighted = YES;
        }
    }
    
    id properties = getPropertiesBlock(css, selectorString);
    if(!properties && highlighted)
        properties = getPropertiesBlock(css, div);
    return properties;
}

+ (void)stylizeItem:(id)item withProperties:(NSDictionary*)properties mapping:(NSDictionary*)mapping parentItem:(id)parentItem {
    for(NSNumber *propertyKey in properties) {
        NSString *cocoaKey = mapping[propertyKey];
        id val = properties[propertyKey];
       
        if([item isKeyValueCompliantForKey:cocoaKey]) {
            [item setValue:val forKey:cocoaKey];
        }
        else if(propertyKey.integerValue == CSSRelationships) {
            [self setupRelationshipsForItem:item parentItem:parentItem relationships:val];
        }
    }
}

+ (void)setupRelationshipsForItem:(id)item parentItem:(id)parentItem relationships:(NSArray*)relationships {    
    for(CSSRelationship* relationship in relationships) {
        
        BOOL shouldContinue = NO;
        if(relationship.predicates) {
            for(NSPredicate *predicate in relationship.predicates) {
                if([predicate evaluateWithObject:parentItem] == NO) {
                    shouldContinue = YES;
                    break;
                }
            }
            
            if(shouldContinue)
                continue;
        }
        
        id relatedToItem;
        if(relationship.relatedToKeyPath) {
            if([relationship.relatedToKeyPath isEqualToString:@"self"])
                relatedToItem = parentItem;
            else relatedToItem = [parentItem valueForKeyPath:relationship.relatedToKeyPath];
        }
        
        NSLayoutAttribute attribute = [CSSRelationship attributeForRelationshipType:relationship.relationshipType];
        
        if(attribute == NSLayoutAttributeHeight || attribute == NSLayoutAttributeWidth) {
            NSLayoutAttribute secondAttribute = relatedToItem ? attribute : NSLayoutAttributeNotAnAttribute;
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:relatedToItem attribute:secondAttribute multiplier:1.0 constant:relationship.offset];
            [[item superview] addConstraint:constraint];
        }
        
        else if(attribute != NSNotFound && relatedToItem) {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:relatedToItem attribute:attribute multiplier:1.0 constant:relationship.offset];
                [self removeConstraintsThatConflictWithConstraint:constraint fromView:item];
            [[item superview] addConstraint:constraint];
        }
        
        else if(relationship.relationshipType == CSSRelationshipTrailVertically) {
            NSString *format = str(@"V:[relatedToItem]-%f-[item]", relationship.offset);
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:0 views:NSDictionaryOfVariableBindings(item, relatedToItem)];
            [self removeConstraintsThatConflictWithConstraint:constraints.lastObject fromView:item];
            [[item superview] addConstraints:constraints];
        }
        
        else {
            @throw [NSException new];
        }
    }
}

+ (void)removeConstraintsThatConflictWithConstraint:(NSLayoutConstraint*)targetConstraint fromView:(UIView*)view {
    NSMutableSet *conflictingConstraints = [self conflictingAttributesForAttribute:targetConstraint.firstAttribute].mutableCopy;
    [conflictingConstraints addObjectsFromArray:[self conflictingAttributesForAttribute:targetConstraint.secondAttribute].allObjects];
    for(NSLayoutConstraint *constraint in view.superview.constraints.copy) {
        if([conflictingConstraints containsObject:@(constraint.firstAttribute)]) {
            if(eql(constraint.firstItem, view) || eql(constraint.secondItem, view)) {
                [view.superview removeConstraint:constraint];
            }
        }
    }
}

+ (NSSet*)conflictingAttributesForAttribute:(NSLayoutAttribute)attribute {
    NSMutableSet *conflictingSet1 = [NSMutableSet setWithArray:@[@(NSLayoutAttributeBottom), @(NSLayoutAttributeTop), @(NSLayoutAttributeCenterY)]];
    if([conflictingSet1 containsObject:@(attribute)]) {
        [conflictingSet1 minusSet:[NSSet setWithArray:@[@(attribute)]]];
        return conflictingSet1;
        
    }
    
    return nil;
}

static NSString *divIDKey = @"CSSDivID";

- (void)setDivID:(NSString *)divID {
    objc_setAssociatedObject(self, &divIDKey, divID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)divID {
    return objc_getAssociatedObject(self, &divIDKey);
}

@end

@implementation UIView (CSS)

static NSString *CSSHighlighted = @"CSSHighlighted";

- (void)setHighlighted:(BOOL)highlighted {
    objc_setAssociatedObject(self, &CSSHighlighted, @(highlighted), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isHighlighted {
    return [objc_getAssociatedObject(self, &CSSHighlighted) boolValue];
}

@end