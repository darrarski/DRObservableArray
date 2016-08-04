//
// Created by Dariusz Rybicki on 03/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "DRObservableArray.h"

/**
 * `DRObservableMutableArray` defines ordered collection that
 * you can modify using provided methods.
 */
@protocol DRObservableMutableArray <DRObservableArray>

/**
 * Sets objects from array
 *
 * @param objects Array of objects
 */
- (void)setObjects:(NSArray *)objects;

/**
 * Inserts object at given index
 *
 * @param object Object
 * @param index Index
 */
- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index;

/**
 * Removes object at given index
 *
 * @param index Index
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
 * Replaces object at given index with provided object
 *
 * @param index Index of object to replace
 * @param object Replacement object
 */
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;

/**
 * Moves object at given index to another index
 *
 * @param index Index of object
 * @param newIndex New index of object
 */
- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex;

/**
 * Exchanges objects with given indexes
 *
 * @param index1 Index of first object
 * @param index2 Index of second object
 */
- (void)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2;

@end
