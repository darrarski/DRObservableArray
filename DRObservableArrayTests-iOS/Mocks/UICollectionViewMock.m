//
// Created by Dariusz Rybicki on 09/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "UICollectionViewMock.h"

@implementation UICollectionViewMock

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 480) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
        _operationStrings = [NSMutableArray new];
    }
    return self;
}

- (void)reloadData
{
    [self.operationStrings addObject:[self stringForReloadData]];
}

- (NSString *)stringForReloadData
{
    return @"reloadData";
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self.operationStrings addObject:[self stringForInsertItemsAtIndexPaths:indexPaths]];
}

- (NSString *)stringForInsertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    return [NSString stringWithFormat:@"insertItemsAtIndexPaths:[%@]",
            [self stringForIndexPaths:indexPaths]];
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self.operationStrings addObject:[self stringForDeleteItemsAtIndexPaths:indexPaths]];
}

- (NSString *)stringForDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    return [NSString stringWithFormat:@"deleteItemsAtIndexPaths:[%@]",
            [self stringForIndexPaths:indexPaths]];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self.operationStrings addObject:[self stringForReloadItemsAtIndexPaths:indexPaths]];
}

- (NSString *)stringForReloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    return [NSString stringWithFormat:@"reloadItemsAtIndexPaths:[%@]",
            [self stringForIndexPaths:indexPaths]];
}

- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    [self.operationStrings addObject:[self stringForMoveItemAtIndexPath:indexPath toIndexPath:newIndexPath]];
}

- (NSString *)stringForMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    return [NSString stringWithFormat:@"moveItemAtIndexPaths:[%@] toIndexPath:[%@]",
            [self stringForIndexPath:indexPath],
            [self stringForIndexPath:newIndexPath]];
}

#pragma mark - Helpers

- (NSString *)stringForIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%@.%@", @(indexPath.section), @(indexPath.row)];
}

- (NSString *)stringForIndexPaths:(NSArray <NSIndexPath *> *)indexPaths
{
    NSMutableArray *strings = [NSMutableArray new];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        [strings addObject:[self stringForIndexPath:indexPath]];
    }];
    return [strings componentsJoinedByString:@", "];
}

@end
