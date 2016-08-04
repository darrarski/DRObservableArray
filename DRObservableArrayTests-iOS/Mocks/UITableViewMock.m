//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "UITableViewMock.h"

@implementation UITableViewMock

- (instancetype)init
{
    if (self = [super init]) {
        _operationStrings = [NSMutableArray new];
    }
    return self;
}

- (void)beginUpdates
{
    [self.operationStrings addObject:[self stringForBeginUpdates]];
}

- (NSString *)stringForBeginUpdates
{
    return @"beginUpdates";
}

- (void)endUpdates
{
    [self.operationStrings addObject:[self stringForEndUpdates]];
}

- (NSString *)stringForEndUpdates
{
    return @"endUpdates";
}

- (void)reloadData
{
    [self.operationStrings addObject:[self stringForReloadData]];
}

- (NSString *)stringForReloadData
{
    return @"reloadData";
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.operationStrings addObject:[self stringForInsertRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimation)animation]];
}

- (NSString *)stringForInsertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    return [NSString stringWithFormat:@"insertRowsAtIndexPaths:[%@] withRowAnimation:[%@]",
            [self stringForIndexPaths:indexPaths],
            [self stringForAnimation:animation]];
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.operationStrings addObject:[self stringForDeleteRowsAtIndexPaths:indexPaths withRowAnimation:animation]];
}

- (NSString *)stringForDeleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    return [NSString stringWithFormat:@"deleteRowsAtIndexPaths:[%@] withRowAnimation:[%@]",
                                      [self stringForIndexPaths:indexPaths],
                                      [self stringForAnimation:animation]];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.operationStrings addObject:[self stringForReloadRowsAtIndexPaths:indexPaths withRowAnimation:animation]];
}

- (NSString *)stringForReloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    return [NSString stringWithFormat:@"reloadRowsAtIndexPaths:[%@] withRowAnimation:[%@]",
                                      [self stringForIndexPaths:indexPaths],
                                      [self stringForAnimation:animation]];
}

- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    [self.operationStrings addObject:[self stringForMoveRowAtIndexPath:indexPath toIndexPath:newIndexPath]];
}


- (NSString *)stringForMoveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    return [NSString stringWithFormat:@"moveRowAtIndexPath:[%@] toIndexPath:[%@]",
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

- (NSString *)stringForAnimation:(UITableViewRowAnimation)animation
{
    switch (animation) {
        case UITableViewRowAnimationFade: return @"Fade";
        case UITableViewRowAnimationRight: return @"Right";
        case UITableViewRowAnimationLeft: return @"Left";
        case UITableViewRowAnimationTop: return @"Top";
        case UITableViewRowAnimationBottom: return @"Bottom";
        case UITableViewRowAnimationNone: return @"None";
        case UITableViewRowAnimationMiddle: return @"Middle";
        case UITableViewRowAnimationAutomatic: return @"Automatic";
    }
    return @"";
}

@end
