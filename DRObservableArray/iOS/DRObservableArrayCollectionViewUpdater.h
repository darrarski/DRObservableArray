//
// Created by Dariusz Rybicki on 08/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRObservableArrayObserver.h"

typedef UICollectionView *(^ObservableArrayCollectionViewUpdaterTableViewBlock)();
typedef NSUInteger (^ObservableArrayCollectionViewUpdaterSectionBlock)();

/**
 * `DRObservableArrayCollectionViewUpdater` is a `DRObservableArrayObserver` that updates
 * `UICollectionView` automatically whenever observable array changes content.
 */
@interface DRObservableArrayCollectionViewUpdater : NSObject <DRObservableArrayObserver>

/**
 * Initializes observer with given collection view and section blocks
 *
 * @param collectionViewBlock A block that returns `UICollectionView` instance
 * @param sectionBlock A block that returns collection view's section index
 * @return The newly-initialized observer
 */
- (instancetype)initWithCollectionViewBlock:(ObservableArrayCollectionViewUpdaterTableViewBlock)collectionViewBlock
                               sectionBlock:(ObservableArrayCollectionViewUpdaterSectionBlock)sectionBlock;

@end
