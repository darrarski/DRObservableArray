//
// Created by Dariusz Rybicki on 08/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "DRObservableArrayCollectionViewUpdater.h"

@interface DRObservableArrayCollectionViewUpdater ()

@property (nonatomic, copy, readonly) ObservableArrayCollectionViewUpdaterTableViewBlock collectionViewBlock;
@property (nonatomic, copy, readonly) ObservableArrayCollectionViewUpdaterSectionBlock sectionBlock;

@end

@implementation DRObservableArrayCollectionViewUpdater

- (instancetype)initWithCollectionViewBlock:(ObservableArrayCollectionViewUpdaterTableViewBlock)collectionViewBlock
                               sectionBlock:(ObservableArrayCollectionViewUpdaterSectionBlock)sectionBlock
{
    if (self = [super init]) {
        _collectionViewBlock = collectionViewBlock;
        _sectionBlock = sectionBlock;
    }
    return self;
}

#pragma mark - Helpers

- (UICollectionView *)collectionView
{
    return self.collectionViewBlock ? self.collectionViewBlock() : nil;
}

- (NSUInteger)section
{
    return self.sectionBlock ? self.sectionBlock() : 0;
}

- (NSIndexPath *)collectionViewIndexPathFromObjectIndex:(NSUInteger)index
{
    return [NSIndexPath indexPathForRow:index inSection:self.section];
}

#pragma mark - ObservableArrayObserver

- (void)observableArrayWillChangeObjects:(id <DRObservableArray>)array
{

}

- (void)observableArrayDidChangeObjects:(id <DRObservableArray>)array
{

}

- (void)observableArrayDidSetObjects:(id <DRObservableArray>)array
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)observableArray:(id <DRObservableArray>)array didInsertObject:(id)object atIndex:(NSUInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView insertItemsAtIndexPaths:@[[self collectionViewIndexPathFromObjectIndex:index]]];
    });
}

- (void)observableArray:(id <DRObservableArray>)array didRemoveObject:(id)object atIndex:(NSUInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView deleteItemsAtIndexPaths:@[[self collectionViewIndexPathFromObjectIndex:index]]];
    });
}

- (void)observableArray:(id <DRObservableArray>)array didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index withObject:(id)newObject
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadItemsAtIndexPaths:@[[self collectionViewIndexPathFromObjectIndex:index]]];
    });
}

- (void)observableArray:(id <DRObservableArray>)array didMoveObject:(id)object fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView moveItemAtIndexPath:[self collectionViewIndexPathFromObjectIndex:fromIndex]
                                     toIndexPath:[self collectionViewIndexPathFromObjectIndex:toIndex]];
    });
}

@end
