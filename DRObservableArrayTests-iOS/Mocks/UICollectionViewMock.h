//
// Created by Dariusz Rybicki on 09/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewMock : UICollectionView

@property (nonatomic, strong, readonly) NSMutableArray <NSString *> *operationStrings;

- (NSString *)stringForReloadData;
- (NSString *)stringForInsertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (NSString *)stringForDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (NSString *)stringForReloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (NSString *)stringForMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;

@end
