//
//  Ship.h
//  objc-Captain-Morgans-Relationships
//
//  Created by Yoseob Lee on 7/17/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Engine, Pirate;

@interface Ship : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Pirate *pirate;
@property (nonatomic, retain) Engine *engine;

@end
