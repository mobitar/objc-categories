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
    if([css respondsToSelector:@selector(mainProperties)])
        [CSSHelper stylizeItem:self withProperties:[css mainProperties] mapping:mapping parentItem:nil];
    
    unsigned propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &propertyCount);
    
    [self configureSuperviewsForProperties:properties count:propertyCount css:css];
    
    for (unsigned i = 0; i < propertyCount; ++i) {
        objc_property_t prop = properties[i];
        NSString *propertyName = $str(@"%s", property_getName(prop));
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
        NSString *propertyName = $str(@"%s", property_getName(prop));
        id item = [self valueForKey:propertyName];
        if([item divID])
            propertyName = [item divID];
        
        ext_propertyAttributes attributes = *ext_copyPropertyAttributes(prop);
        if(!item) {
            item = attributes.objectClass.new;
            if(item)
                [self performSelector:attributes.setter withObject:item];
        }
        
        if(item) {
            NSDictionary *properties = [self.class propertiesForDiv:propertyName item:item fromClass:css];
            if([item respondsToSelector:@selector(superview)]) {
                if(properties[@(CSSSuperview)] || ![item superview]) {
                    id superview = self;
                    NSString *superviewKeyPath = properties[@(CSSSuperview)];
                    if(superviewKeyPath) {
                        if($eql(superviewKeyPath, @"self")) {
                            superview = self;
                        } else {
                            superview = [self valueForKeyPath:superviewKeyPath];
                        }
                    }
                    [superview addSubview:item];
                }
            }
            
            if([item respondsToSelector:@selector(setTranslatesAutoresizingMaskIntoConstraints:)]) {
                if(properties[@(CSSHasDefaultConstraints)]) {
                    BOOL hasDefaultConstraints = [properties[@(CSSHasDefaultConstraints)] boolValue];
                    [item setTranslatesAutoresizingMaskIntoConstraints:hasDefaultConstraints];
                } else {
                    [item setTranslatesAutoresizingMaskIntoConstraints:NO];
                }
            }
        }
    }
}

//- (void)stylizeItem:(id)item divKey:(NSString*)key withCSSClass:(Class<CSS>)css {
//    [CSSHelper stylizeItem:item withProperties:[self.class propertiesForDiv:key item:item fromClass:css] mapping:[CSSHelper CSStoUIKITMapping]];
//}

+ (NSDictionary*)propertiesForDiv:(NSString*)div item:(id)item fromClass:(Class)css {
    SEL selector = NSSelectorFromString(div);
    if(![css respondsToSelector:selector]) {
        return nil;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[css methodSignatureForSelector:selector]];
    invocation.target = css;
    invocation.selector = selector;
    [invocation invoke];
    
    __unsafe_unretained id val = nil;
    [invocation getReturnValue:&val];
    return val;
}

+ (void)stylizeItem:(id)item withProperties:(NSDictionary*)properties mapping:(NSDictionary*)mapping parentItem:(id)parentItem {
    for(NSNumber *propertyKey in properties) {
        NSString *cocoaKey = mapping[propertyKey];
        id val = properties[propertyKey];
       
        if([item isKeyValueCompliantForKey:cocoaKey]) {
            [item setValue:val forKey:cocoaKey];
        }
        
        else {
            if(propertyKey.integerValue == CSSHorizontalPadding) {
                [self removeConstraintForItem:[item superview] relatedTo:item attribute:NSLayoutAttributeWidth];
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[item superview] attribute:NSLayoutAttributeWidth multiplier:1.0 constant:(-[val floatValue] * 2)];
                [[item superview] addConstraint:constraint];
            }
            
            else if(propertyKey.integerValue == CSSRelationships) {
                [self setupRelationshipForItems:item parentItem:parentItem relationships:val];
            }
        }
    }
}

+ (void)setupRelationshipForItems:(id)item parentItem:(id)parentItem relationships:(NSArray*)relationships {
    for(CSSRelationship* relationship in relationships) {
        id relatedToItem;
        if(relationship.relatedToKeyPath) {
            if([relationship.relatedToKeyPath isEqualToString:@"self"])
                relatedToItem = parentItem;
            else relatedToItem = [parentItem valueForKeyPath:relationship.relatedToKeyPath];
        }
        [self removeConstraintForItem:item relatedTo:relatedToItem attribute:NSLayoutAttributeTop];
        
        NSLayoutAttribute attribute = [CSSRelationship attributeForRelationshipType:relationship.relationshipType];
        
        if(attribute == NSLayoutAttributeHeight || attribute == NSLayoutAttributeWidth) {
            NSLayoutAttribute secondAttribute = relatedToItem ? attribute : NSLayoutAttributeNotAnAttribute;
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:relatedToItem attribute:secondAttribute multiplier:1.0 constant:relationship.offset];
            [[item superview] addConstraint:constraint];
        }
        
        else if(attribute != NSNotFound && relatedToItem) {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:relatedToItem attribute:attribute multiplier:1.0 constant:relationship.offset];
            [[item superview] addConstraint:constraint];
        }
        
        else if(relationship.relationshipType == CSSRelationshipTrailVertically) {
            NSString *format = $str(@"V:[relatedToItem]-%f-[item]", relationship.offset);
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:0 views:NSDictionaryOfVariableBindings(item, relatedToItem)];
            [[item superview] addConstraints:constraints];
        }
        
        else {
            @throw [NSException new];
        }

    }
}

+ (void)removeConstraintForItem:(id)item relatedTo:(id)relatedItem attribute:(NSLayoutAttribute)attribute {
    for(NSLayoutConstraint *constraint in [[item constraints] copy]) {
        if(
           ($eql(constraint.firstItem, item) || $eql(constraint.secondItem, item))
           && ($eql(constraint.secondItem, relatedItem) || $eql(constraint.firstItem, relatedItem))
           && attribute == constraint.firstAttribute
           )
        {
            [item removeConstraint:constraint];
        }
    }
}

static NSString *divIDKey = @"CSSDivID";

- (void)setDivID:(NSString *)divID {
    objc_setAssociatedObject(self, &divIDKey, divID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)divID {
    return objc_getAssociatedObject(self, &divIDKey);
}

@end