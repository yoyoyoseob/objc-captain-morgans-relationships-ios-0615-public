//
//  Engine.h
//  objc-Captain-Morgans-Relationships
//
//  Created by Yoseob Lee on 7/17/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ship;

@interface Engine : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Ship *ship;

@end
