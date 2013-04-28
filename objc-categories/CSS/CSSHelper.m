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
        id view = [self valueForKey:propertyName];
        if([view divID])
            propertyName = [view divID];
        
        ext_propertyAttributes attributes = *ext_copyPropertyAttributes(prop);
        if(!view) {
            view = attributes.objectClass.new;
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:attributes.setter withObject:view];
#pragma clang diagnostic pop
        }

        NSDictionary *properties = [self.class propertiesForDiv:propertyName item:view fromClass:css];
        
        id origItem = nil;
        // by default we'll add a view controller's view property, but you can specify a custom subview such as tableView or collectionView with this:
        if(properties[@(CSSWhichSubview)]) {
            NSString *subviewKeyPath = properties[@(CSSWhichSubview)];
            origItem = view;
            view = [view valueForKeyPath:subviewKeyPath];
        }
        else if([view isKindOfClass:[UIViewController class]]) {
            origItem = view;
            view = [view view];
        }
        
        if([view isKindOfClass:[UIView class]] && ![view superview]) {
            id superview = self;
            if(properties[@(CSSSuperview)]) {
                NSString *superviewKeyPath = properties[@(CSSSuperview)];
                if($eql(superviewKeyPath, @"self") == NO) {
                    superview = [self valueForKeyPath:superviewKeyPath];
                }
            }
            
            if([superview isKindOfClass:[UIViewController class]])
                superview = [superview view];
            
            [superview addSubview:view];
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
        else if(propertyKey.integerValue == CSSRelationships) {
//            [item removeConstraints:[item constraints]];
            [self setupRelationshipsForItem:item parentItem:parentItem relationships:val];
        }
    }
}

+ (void)setupRelationshipsForItem:(id)item parentItem:(id)parentItem relationships:(NSArray*)relationships {    
    for(CSSRelationship* relationship in relationships) {
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

static NSString *divIDKey = @"CSSDivID";

- (void)setDivID:(NSString *)divID {
    objc_setAssociatedObject(self, &divIDKey, divID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)divID {
    return objc_getAssociatedObject(self, &divIDKey);
}

@end