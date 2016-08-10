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
    return [NSString stringWithFormat:@"reloadData on %@", [self stringForQueue]];
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self.operationStrings addObject:[self stringForInsertItemsAtIndexPaths:indexPaths]];
}

- (NSString *)stringForInsertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    return [NSString stringWithFormat:@"insertItemsAtIndexPaths:[%@] on %@",
            [self stringForIndexPaths:indexPaths],
            [self stringForQueue]];
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self.operationStrings addObject:[self stringForDeleteItemsAtIndexPaths:indexPaths]];
}

- (NSString *)stringForDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    return [NSString stringWithFormat:@"deleteItemsAtIndexPaths:[%@] on %@",
            [self stringForIndexPaths:indexPaths],
            [self stringForQueue]];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self.operationStrings addObject:[self stringForReloadItemsAtIndexPaths:indexPaths]];
}

- (NSString *)stringForReloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    return [NSString stringWithFormat:@"reloadItemsAtIndexPaths:[%@] on %@",
            [self stringForIndexPaths:indexPaths],
            [self stringForQueue]];
}

- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    [self.operationStrings addObject:[self stringForMoveItemAtIndexPath:indexPath toIndexPath:newIndexPath]];
}

- (NSString *)stringForMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    return [NSString stringWithFormat:@"moveItemAtIndexPaths:[%@] toIndexPath:[%@] on %@",
            [self stringForIndexPath:indexPath],
            [self stringForIndexPath:newIndexPath],
            [self stringForQueue]];
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

- (NSString *)stringForQueue
{
    return [NSString stringWithUTF8String:dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)];
}

@end
