//
//  NSFetchedResultsController+Utilities.m
//  nubhub
//
//  Created by Bitar on 3/18/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "NSFetchedResultsController+Utilities.h"

@implementation NSFetchedResultsController (Utilities)

- (NSUInteger)numberOfObjectsInSection:(NSInteger)section {
    return [[self.sections objectAtIndex:section] numberOfObjects];
}

- (NSString*)sectionNameForSectionIndex:(NSUInteger)index {
    id<NSFetchedResultsSectionInfo> section = [self.sections objectAtIndex:index];
    return [section name];
}

- (id)initWithEntityName:(NSString*)name predicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)descriptors context:(NSManagedObjectContext*)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    request.predicate = predicate;
    request.sortDescriptors = descriptors;
    
    self = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    if(!self) return nil;
    
    NSError *error = nil;
    if([self performFetch:&error] == NO) {
        NSLog(@"Error:%@", error.description);
        exit(0);
    }
    return self;
}

@end
