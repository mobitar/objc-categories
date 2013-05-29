//
//  NSManagedObjectContext+Utilities.m
//  Mass
//
//  Created by Mo Bitar on 5/27/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "NSManagedObjectContext+Utilities.h"

@implementation NSManagedObjectContext (Utilities)
- (NSArray*)fetchEntity:(NSString*)entityName predicate:(NSPredicate*)predicate sorts:(NSArray*)sortDescriptors {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = predicate;
    request.sortDescriptors = sortDescriptors;
    return [self executeFetchRequest:request error:nil];
}
@end
