//
// Created by Dariusz Rybicki on 03/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRObservableArrayObserver.h"
#import "DRObservableArrayObserversSet.h"

@protocol DRObservableArray <NSObject>

- (DRObservableArrayObserversSet *)observers;

- (NSArray *)objects;
- (NSUInteger)objectsCount;
- (id)objectAtIndex:(NSUInteger)index;

@end
