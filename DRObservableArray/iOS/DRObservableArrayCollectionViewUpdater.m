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
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
        _operationQueue.qualityOfService = NSOperationQualityOfServiceUserInteractive;
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

- (void)addOperation:(void (^)())block
{
    [self.operationQueue addOperationWithBlock:^{
        dispatch_sync(dispatch_get_main_queue(), block);
    }];
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
    UICollectionView *collectionView = self.collectionView;
    [self addOperation:^{
        [collectionView reloadData];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didInsertObject:(id)object atIndex:(NSUInteger)index
{
    UICollectionView *collectionView = self.collectionView;
    NSIndexPath *indexPath = [self collectionViewIndexPathFromObjectIndex:index];
    [self addOperation:^{
        [collectionView insertItemsAtIndexPaths:@[indexPath]];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didRemoveObject:(id)object atIndex:(NSUInteger)index
{
    UICollectionView *collectionView = self.collectionView;
    NSIndexPath *indexPath = [self collectionViewIndexPathFromObjectIndex:index];
    [self addOperation:^{
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index withObject:(id)newObject
{
    UICollectionView *collectionView = self.collectionView;
    NSIndexPath *indexPath = [self collectionViewIndexPathFromObjectIndex:index];
    [self addOperation:^{
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didMoveObject:(id)object fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    UICollectionView *collectionView = self.collectionView;
    NSIndexPath *fromIndexPath = [self collectionViewIndexPathFromObjectIndex:fromIndex];
    NSIndexPath *toIndexPath = [self collectionViewIndexPathFromObjectIndex:toIndex];
    [self addOperation:^{
        [collectionView moveItemAtIndexPath:fromIndexPath
                                toIndexPath:toIndexPath];
    }];
}

@end
