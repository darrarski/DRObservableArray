//
// Created by Dariusz Rybicki on 03/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRObservableArrayObserver.h"
#import "DRObservableArrayObserversSet.h"

/**
 * `DRObservableArray` defines ordered collection that you can subscribe to
 * in order be notified whenever its content changes.
 */
@protocol DRObservableArray <NSObject>

/**
 * Returns observers set so you can add or remove observer
 *
 * @return Observers set
 */
- (DRObservableArrayObserversSet *)observers;

/**
 * Returns all objects
 *
 * @return All objects
 */
- (NSArray *)allObjects;

/**
 * Returns count of objects
 *
 * @return Count of objects
 */
- (NSUInteger)count;

/**
 * Returns object at given index
 *
 * @param index Index of object
 * @return Object
 */
- (id)objectAtIndex:(NSUInteger)index;

@end
