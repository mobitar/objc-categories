//
//  CSSHelper.m
//
//  Created by Mo Bitar on 4/14/13.
//

#import "CSSHelper.h"
#import <objc/runtime.h>
#import "CSSTextHelper.h"

#pragma mark - CSS Categories

@implementation UIView (CSS)

+ (NSDictionary*)CSStoUIKITMapping {
    return @{
             @(CSSBackgroundColor)   : @"backgroundColor",
             @(CSSVerticalAlignment) : @"contentVerticalAlignment",
             @(CSSOpacity)           : @"alpha",
             @(CSSImage)             : @"image"
             };
}

- (void)stylizeWithCSSClass:(Class)css {
    NSDictionary *mapping = [UIView CSStoUIKITMapping];
    
    if([css respondsToSelector:@selector(selfProperties)]) {
        NSDictionary *properties = [self.class propertiesForDiv:@"selfProperties" item:self fromClass:css];
        [UIView stylizeItem:self withProperties:properties mapping:mapping parentItem:nil];
    }
    
    unsigned propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &propertyCount);
    
    for (unsigned i = 0; i < propertyCount; ++i) {
        objc_property_t prop = properties[i];
        NSString *propertyName = str(@"%s", property_getName(prop));
        id item = [self valueForKey:propertyName];
        if(is(item, UIView) && [item divID]) {
            propertyName = [item divID];
            NSDictionary *properties = [self.class propertiesForDiv:propertyName item:item fromClass:css];
            [self.class stylizeItem:item withProperties:properties mapping:mapping parentItem:self];
        }
    }
}

- (void)stylizeItem:(UIView*)item withCSSClass:(Class<CSS>)css {
    [UIView stylizeItem:item withProperties:[self.class propertiesForDiv:[item divID] item:item fromClass:css] mapping:[UIView CSStoUIKITMapping] parentItem:self];
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
        if(propertyKey.integerValue == CSSRelationships) {
            [self setupRelationshipsForItem:item parentItem:parentItem relationships:val];
        } else if(propertyKey.integerValue == CSSTextAttributes) {
            [CSSTextHelper setupTextForItem:item parentItem:parentItem usingAttributes:val];
        } else {
            [self configureItem:item withCocoaKey:cocoaKey value:val parentItem:parentItem];
        }
    }
}

+ (void)configureItem:(id)item withCocoaKey:(NSString*)cocoaKey value:(id)value parentItem:(id)parentItem {    
    if(is(value, CSSKeyPath)) {
        value = [value evaluateWithItem:item parentItem:parentItem];
    }
    
    if([item isKeyValueCompliantForKey:cocoaKey]) {
        [item setValue:value forKey:cocoaKey];
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
            id rootItem = parentItem;
            if([relationship.relatedToKeyPath contains:@"self"])
                rootItem = item;
           
            relatedToItem = [rootItem valueForKeyPath:relationship.relatedToKeyPath];
        }
        
        NSLayoutAttribute attribute = [CSSRelationship attributeForRelationshipType:relationship.relationshipType];
                
        if(attribute != NSNotFound ) {
            NSLayoutAttribute secondAttribute = relatedToItem ? attribute : NSLayoutAttributeNotAnAttribute;
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:relatedToItem attribute:secondAttribute multiplier:1.0 constant:relationship.offset];
            [self removeConstraintsThatConflictWithConstraint:constraint fromView:item];
            if([[item superview] containsConstraint:constraint] == NO)
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
    NSMutableSet *conflictingSet1 = [NSMutableSet setWithArray:@[@(NSLayoutAttributeBottom),@(NSLayoutAttributeTop),@(NSLayoutAttributeCenterY)]];
    if([conflictingSet1 containsObject:@(attribute)]) {
        [conflictingSet1 minusSet:[NSSet setWithArray:@[@(attribute)]]];
        return conflictingSet1;
    }
    
    // TODO: more conflicting sets
    
    return nil;
}

static NSString *divIDKey = @"CSSDivID";

- (void)setDivID:(NSString *)divID {
    objc_setAssociatedObject(self, &divIDKey, divID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)divID {
    return objc_getAssociatedObject(self, &divIDKey);
}

+ (id)newWithDivId:(NSString*)divID addToView:(UIView*)view {
    id item = [self new];
    [item setTranslatesAutoresizingMaskIntoConstraints:NO];
    [item setDivID:divID];
    [view addSubview:item];
    return item;
}

static NSString *CSSHighlighted = @"CSSHighlighted";

- (void)setHighlighted:(BOOL)highlighted {
    objc_setAssociatedObject(self, &CSSHighlighted, @(highlighted), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isHighlighted {
    return [objc_getAssociatedObject(self, &CSSHighlighted) boolValue];
}

@end