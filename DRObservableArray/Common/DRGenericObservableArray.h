//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "DRObservableArray.h"
#import "DRObservableMutableArray.h"

/**
 * `DRGenericObservableArray` is a generic observable mutable array build on top of `NSMutableArray`
 */
@interface DRGenericObservableArray : NSObject <DRObservableArray, DRObservableMutableArray>

@end
