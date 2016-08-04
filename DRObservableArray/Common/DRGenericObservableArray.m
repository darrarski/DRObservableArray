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
    [self.observers observableArrayWillChangeObjects:self];
    _objects = [objects mutableCopy];
    [self.observers observableArrayDidSetObjects:self];
    [self.observers observableArrayDidChangeObjects:self];
}

- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index
{
    [self.observers observableArrayWillChangeObjects:self];
    [_objects insertObject:object atIndex:index];
    [self.observers observableArray:self didInsertObject:object atIndex:index];
    [self.observers observableArrayDidChangeObjects:self];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self.observers observableArrayWillChangeObjects:self];
    id object = _objects[index];
    [_objects removeObjectAtIndex:index];
    [self.observers observableArray:self didRemoveObject:object atIndex:index];
    [self.observers observableArrayDidChangeObjects:self];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    [self.observers observableArrayWillChangeObjects:self];
    id replacedObject = _objects[index];
    _objects[index] = object;
    [self.observers observableArray:self didReplaceObject:replacedObject atIndex:index withObject:object];
    [self.observers observableArrayDidChangeObjects:self];
}

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex
{
    if (newIndex == index) return;
    [self.observers observableArrayWillChangeObjects:self];
    id object = _objects[index];
    [_objects removeObjectAtIndex:index];
    [_objects insertObject:object atIndex:newIndex];
    [self.observers observableArray:self didMoveObject:object fromIndex:index toIndex:newIndex];
    [self.observers observableArrayDidChangeObjects:self];
}

- (void)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    [self moveObjectAtIndex:index1 toIndex:index2];
    [self moveObjectAtIndex:index1 < index2 ? index2 - 1 : index2 + 1
                    toIndex:index1];
}

@end
