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
 * @param newObject New object
 */
- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index withObject:(id)newObject;

/**
 * This method is called when object is moved in collection
 *
 * @param object Moved object
 * @param fromIndex Previous index of the object
 * @param toIndex New (current) index of the object
 */
- (void)didMoveObject:(id)object fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
