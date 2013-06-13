//
//  NSManagedObjectContext+Utilities.h
//  Mass
//
//  Created by Mo Bitar on 5/27/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Utilities)
- (NSArray*)fetchEntity:(NSString*)entityName predicate:(NSPredicate*)predicate sorts:(NSArray*)sortDescriptors;
@end
