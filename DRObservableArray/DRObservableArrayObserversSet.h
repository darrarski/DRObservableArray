//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRObservableArrayObserver.h"

@interface DRObservableArrayObserversSet : NSObject <DRObservableArrayObserver>

- (void)addObserver:(NSObject <DRObservableArrayObserver> *)observer;
- (void)removeObserver:(NSObject <DRObservableArrayObserver> *)observer;

@end
