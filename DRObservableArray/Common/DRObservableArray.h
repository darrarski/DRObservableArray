//
// Created by Dariusz Rybicki on 03/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRObservableArrayObserver.h"
#import "DRObservableArrayObserversSet.h"

@protocol DRObservableArray <NSObject>

- (DRObservableArrayObserversSet *)observers;

- (NSArray *)allObjects;
- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;

@end