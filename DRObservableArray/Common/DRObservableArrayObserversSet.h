//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRObservableArrayObserver.h"

/**
 * `DRObservableArrayObserversSet` is a set of `DRObservableArrayObserver` objects that
 * acts like a proxy. Observer objects in the set are referenced using weak reference.
 */
@interface DRObservableArrayObserversSet : NSObject <DRObservableArrayObserver>

/**
 * Add observer to set
 *
 * @warning Object will be referenced in set using weak reference
 *
 * @param observer Observer
 */
- (void)addObserver:(NSObject <DRObservableArrayObserver> *)observer;

/**
 * Remove observer from set
 *
 * @param observer Observer
 */
- (void)removeObserver:(NSObject <DRObservableArrayObserver> *)observer;

@end
