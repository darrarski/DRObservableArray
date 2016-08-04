//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "DRGenericObservableArray.h"

@implementation DRGenericObservableArray {
    DRObservableArrayObserversSet *_observers;
    NSMutableArray *_objects;
}

- (instancetype)init
{
    if (self = [super init]) {
        _observers = [DRObservableArrayObserversSet new];
        _objects = [NSMutableArray new];
    }
    return self;
}

#pragma mark - DRObservableArray

- (DRObservableArrayObserversSet *)observers
{
    return _observers;
}

- (NSArray *)allObjects
{
    return _objects.copy;
}

- (NSUInteger)count
{
    return _objects.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    return _objects[index];
}

#pragma mark - DRObservableArrayObserver

- (void)setObjects:(NSArray *)objects
{
    [self willChangeObjects];
    _objects = [objects mutableCopy];
    [self didSetObjects];
    [self didChangeObjects];
}

- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index
{
    [self willChangeObjects];
    [_objects insertObject:object atIndex:index];
    [self didInsertObject:object atIndex:index];
    [self didChangeObjects];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self willChangeObjects];
    id object = _objects[index];
    [_objects removeObjectAtIndex:index];
    [self didRemoveObject:object atIndex:index];
    [self didChangeObjects];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    [self willChangeObjects];
    id replacedObject = _objects[index];
    _objects[index] = object;
    [self didReplaceObject:replacedObject atIndex:index withObject:object];
    [self didChangeObjects];
}

- (void)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    [self willChangeObjects];
    id object = _objects[index1];
    [_objects removeObjectAtIndex:index1];
    [_objects insertObject:object atIndex:index2];
    [self didMoveObject:object fromIndex:index1 toIndex:index2];
    [self didChangeObjects];
}

- (void)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    [self moveObjectAtIndex:index1 toIndex:index2];
    [self moveObjectAtIndex:index1 < index2 ? index2 - 1 : index2 + 1
                    toIndex:index1];
}

#pragma mark - Events

- (void)willChangeObjects
{
    [self.observers willChangeObjects];
}

- (void)didChangeObjects
{
    [self.observers didChangeObjects];
}

- (void)didSetObjects
{
    [self.observers didSetObjects];
}

- (void)didInsertObject:(id)object atIndex:(NSUInteger)index
{
    [self.observers didInsertObject:object atIndex:index];
}

- (void)didRemoveObject:(id)object atIndex:(NSUInteger)index
{
    [self.observers didRemoveObject:object atIndex:index];
}

- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index withObject:(id)newObject
{
    [self.observers didReplaceObject:replacedObject atIndex:index withObject:newObject];
}

- (void)didMoveObject:(id)object fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    [self.observers didMoveObject:object fromIndex:fromIndex toIndex:toIndex];
}

@end
