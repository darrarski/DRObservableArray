//
// Created by Dariusz Rybicki on 03/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * `DRObservableArrayObserver` defines ordered collection observer that
 * gets notified whenever collection changes.
 */
@protocol DRObservableArrayObserver <NSObject>

/**
 * This method is called when collection is about to change objects
 */
- (void)willChangeObjects;

/**
 * This method is called after collection changed objects
 */
- (void)didChangeObjects;

/**
 * This method is called when collection changed all objects
 */
- (void)didSetObjects;

/**
 * This method is called when a new object is inserted into collection
 *
 * @param object Inserted object
 * @param index Index of inserted object
 */
- (void)didInsertObject:(id)object atIndex:(NSUInteger)index;

/**
 * This method is called when object is removed from collection
 *
 * @param object Removed object
 * @param index Index of removed object
 */
- (void)didRemoveObject:(id)object atIndex:(NSUInteger)index;

/**
 * This method is called when object in collection is replaced with new object
 *
 * @param replacedObject Object that is being replaced
 * @param index Index of replaced object
 */
- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index;

/**
 * This method is called when object is moved in collection
 *
 * @param index1 Previous index of the object
 * @param index2 New (current) index of the object
 */
- (void)didMoveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2;

@end
