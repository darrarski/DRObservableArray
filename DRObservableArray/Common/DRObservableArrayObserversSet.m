//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "DRObservableArrayObserversSet.h"

#pragma mark - ObservableArrayObservers

@interface ObservableArrayObserverWeakReference : NSObject

@property (nonatomic, weak) id <DRObservableArrayObserver> observer;

@end

@implementation ObservableArrayObserverWeakReference

- (instancetype)initWithObserver:(id <DRObservableArrayObserver>)observer
{
    if (self = [super init]) {
        _observer = observer;
    }
    return self;
}

- (BOOL)isEqual:(ObservableArrayObserverWeakReference *)object
{
    if (![object isKindOfClass:[ObservableArrayObserverWeakReference class]]) return NO;
    return self.observer == object.observer;
}

@end

#pragma mark - NSSet+SetByRemovingObject

@interface NSSet (SetByRemovingObject)

- (NSSet *)setByRemovingObject:(id)object;
- (NSSet *)setByRemovingObjects:(NSSet *)objects;

@end

@implementation NSSet (SetByRemovingObject)

- (NSSet *)setByRemovingObject:(id)object
{
    NSMutableArray *allObjects = [self.allObjects mutableCopy];
    [allObjects removeObject:object];
    return [NSSet setWithArray:allObjects];
}

- (NSSet *)setByRemovingObjects:(NSSet *)objects
{
    NSMutableArray *allObjects = [self.allObjects mutableCopy];
    [objects enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
        [allObjects removeObject:object];
    }];
    return [NSSet setWithArray:allObjects];
}

@end

#pragma mark - ObservableArrayObservers

@interface DRObservableArrayObserversSet ()

@property (nonatomic, strong) NSSet <ObservableArrayObserverWeakReference *> *observerReferences;

@end

@implementation DRObservableArrayObserversSet

- (NSSet<ObservableArrayObserverWeakReference *> *)observerReferences
{
    if (!_observerReferences) {
        _observerReferences = [NSSet new];
    }
    return _observerReferences;
}

- (void)addObserver:(id <DRObservableArrayObserver>)observer
{
    [self cleanUpObservers];
    if (observer == nil) return;
    ObservableArrayObserverWeakReference *reference = [[ObservableArrayObserverWeakReference alloc] initWithObserver:observer];
    if ([self.observerReferences containsObject:reference]) return;
    self.observerReferences = [self.observerReferences setByAddingObject:reference];
}

- (void)removeObserver:(id <DRObservableArrayObserver>)observer
{
    [self cleanUpObservers];
    if (observer == nil) return;
    ObservableArrayObserverWeakReference *reference = [[ObservableArrayObserverWeakReference alloc] initWithObserver:observer];
    self.observerReferences = [self.observerReferences setByRemovingObject:reference];
}

- (void)cleanUpObservers
{
    NSMutableSet *nullReferences = [NSMutableSet new];
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        if (reference.observer == nil) [nullReferences addObject:reference];
    }];
    self.observerReferences = [self.observerReferences setByRemovingObjects:nullReferences];
}

- (void)enumerateObserversWithBlock:(void (^)(id <DRObservableArrayObserver>))block
{
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        block(reference.observer);
    }];
}

#pragma mark - ObservableArrayObserver

- (void)observableArrayWillChangeObjects:(id <DRObservableArray>)array
{
    [self enumerateObserversWithBlock:^(id <DRObservableArrayObserver> observer) {
        [observer observableArrayWillChangeObjects:array];
    }];
}

- (void)observableArrayDidChangeObjects:(id <DRObservableArray>)array
{
    [self enumerateObserversWithBlock:^(id <DRObservableArrayObserver> observer) {
        [observer observableArrayDidChangeObjects:array];
    }];
}

- (void)observableArrayDidSetObjects:(id <DRObservableArray>)array
{
    [self enumerateObserversWithBlock:^(id <DRObservableArrayObserver> observer) {
        [observer observableArrayDidSetObjects:array];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didInsertObject:(id)object atIndex:(NSUInteger)index
{
    [self enumerateObserversWithBlock:^(id <DRObservableArrayObserver> observer) {
        [observer observableArray:array didInsertObject:object atIndex:index];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didRemoveObject:(id)object atIndex:(NSUInteger)index
{
    [self enumerateObserversWithBlock:^(id <DRObservableArrayObserver> observer) {
        [observer observableArray:array didRemoveObject:object atIndex:index];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index withObject:(id)newObject
{
    [self enumerateObserversWithBlock:^(id <DRObservableArrayObserver> observer) {
        [observer observableArray:array didReplaceObject:replacedObject atIndex:index withObject:newObject];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didMoveObject:(id)object fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    [self enumerateObserversWithBlock:^(id <DRObservableArrayObserver> observer) {
        [observer observableArray:array didMoveObject:object fromIndex:fromIndex toIndex:toIndex];
    }];
}

@end
