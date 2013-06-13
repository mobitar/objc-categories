//
//  NSFetchedResultsController+Utilities.h
//  nubhub
//
//  Created by Bitar on 3/18/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <CoreData/CoreData.h>
//#import <Foundation/Foundation.h>

@interface NSFetchedResultsController (Utilities)
- (NSUInteger)numberOfObjectsInSection:(NSInteger)section;
- (NSString*)sectionNameForSectionIndex:(NSUInteger)index;
- (id)initWithEntityName:(NSString*)name predicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)descriptors context:(NSManagedObjectContext*)context;
@end
