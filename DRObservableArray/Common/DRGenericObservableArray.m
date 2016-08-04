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
    [self.observers willChangeObjects];
    _objects = [objects mutableCopy];
    [self.observers didSetObjects];
    [self.observers didChangeObjects];
}

- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index
{
    [self.observers willChangeObjects];
    [_objects insertObject:object atIndex:index];
    [self.observers didInsertObject:object atIndex:index];
    [self.observers didChangeObjects];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self.observers willChangeObjects];
    id object = _objects[index];
    [_objects removeObjectAtIndex:index];
    [self.observers didRemoveObject:object atIndex:index];
    [self.observers didChangeObjects];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    [self.observers willChangeObjects];
    id replacedObject = _objects[index];
    _objects[index] = object;
    [self.observers didReplaceObject:replacedObject atIndex:index withObject:object];
    [self.observers didChangeObjects];
}

- (void)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    [self.observers willChangeObjects];
    id object = _objects[index1];
    [_objects removeObjectAtIndex:index1];
    [_objects insertObject:object atIndex:index2];
    [self.observers didMoveObject:object fromIndex:index1 toIndex:index2];
    [self.observers didChangeObjects];
}

- (void)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    [self moveObjectAtIndex:index1 toIndex:index2];
    [self moveObjectAtIndex:index1 < index2 ? index2 - 1 : index2 + 1
                    toIndex:index1];
}

@end
