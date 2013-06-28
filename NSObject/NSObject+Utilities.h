//
//  NSObject+Utilities.h
//  nubhub
//
//  Created by Bitar on 3/19/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Utilities)
- (BOOL)isKeyValueCompliantForKey:(NSString*)key;

/*
 * Populates the properties of self with the propertiesMapping below using the `populatePropertiesFromMappingDictionary` method below.
 */
- (void)populateProperties;

/*
 * Example: @{@"titleLabel" : @{@"text" : self.model.name, "font" : [UIFont font], @"textColor" : [UIColor redColor]}}
 */
- (NSDictionary*)propertiesMapping;

/*
 * Populates the properties of self given as keys in the main dictionary. Values should be a dictionary of properties.
 * Example input: see propertiesMapping above
 * where self has a `titleLabel` property.
 */
- (void)populatePropertiesFromMappingDictionary:(NSDictionary*)mapping;

/*
 * initializes the instance with the given dictionary
 */
- (id)initWithDictionary:(NSDictionary*)dictionary;
- (void)setDynamicValue:(id)value forKey:(NSString *)key;
- (id)getDynamicValueForKey:(NSString *)key;
@end
