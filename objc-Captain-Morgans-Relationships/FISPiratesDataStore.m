//
//  FISPiratesDataStore.m
//  objc-Captain-Morgans-Relationships
//
//  Created by Zachary Drossman on 10/22/14.
//  Copyright (c) 2014 Zachary Drossman. All rights reserved.
//

#import "FISPiratesDataStore.h"
#import "Pirate.h"
#import "Ship.h"
#import "Engine.h"

@implementation FISPiratesDataStore
@synthesize managedObjectContext = _managedObjectContext;

# pragma mark - Singleton

+ (instancetype)sharedPiratesDataStore {
    static FISPiratesDataStore *_sharedPiratesDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPiratesDataStore = [[FISPiratesDataStore alloc] init];
    });

    return _sharedPiratesDataStore;
}

- (void)save
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

- (void) generateTestData
{
    NSArray *shipsPerPirate = @[@3, @2, @5];
    
    for (NSUInteger i = 0; i < shipsPerPirate.count; i ++)
    {
        Pirate *newPirate = [NSEntityDescription insertNewObjectForEntityForName:@"Pirate" inManagedObjectContext:self.managedObjectContext];
        newPirate.name = [NSString stringWithFormat:@"%lu Pirate", i+1];
        
        for (NSUInteger shipCount = 0; shipCount < [shipsPerPirate[i] integerValue]; shipCount ++)
        {
            Ship *newShip = [NSEntityDescription insertNewObjectForEntityForName:@"Ship" inManagedObjectContext:self.managedObjectContext];
            newShip.name = [NSString stringWithFormat:@"%lu Ship", shipCount+1];
            
            newShip.engine = [NSEntityDescription insertNewObjectForEntityForName:@"Engine" inManagedObjectContext:self.managedObjectContext];
            newShip.engine.type = [self randomEngineType];
            
            [newPirate addShipsObject:newShip];
        }
    }
}
                              
- (NSString *)randomEngineType
{
    NSArray *engineTypes = @[@"Sail", @"Gas", @"Electric", @"Plasma Turbines"];
    
    NSInteger randomNumber = arc4random_uniform(4);
    NSString *randomEngine = engineTypes[randomNumber];
    
    return randomEngine;
}

- (void)fetchData
{
    NSFetchRequest *pirateFetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Pirate"];
    NSSortDescriptor *nameSorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    pirateFetchRequest.sortDescriptors = @[nameSorter];
    
    self.pirates = [self.managedObjectContext executeFetchRequest:pirateFetchRequest error:nil];
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }


    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"objcCMR.sqlite"];

    NSError *error = nil;

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"objcCMR" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
