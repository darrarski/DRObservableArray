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
    return [NSString stringWithFormat:@"beginUpdates on %@", [self stringForQueue]];
}

- (void)endUpdates
{
    [self.operationStrings addObject:[self stringForEndUpdates]];
}

- (NSString *)stringForEndUpdates
{
    return [NSString stringWithFormat:@"endUpdates on %@", [self stringForQueue]];
}

- (void)reloadData
{
    [self.operationStrings addObject:[self stringForReloadData]];
}

- (NSString *)stringForReloadData
{
    return [NSString stringWithFormat:@"reloadData on %@", [self stringForQueue]];
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.operationStrings addObject:[self stringForInsertRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimation)animation]];
}

- (NSString *)stringForInsertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    return [NSString stringWithFormat:@"insertRowsAtIndexPaths:[%@] withRowAnimation:[%@] on %@",
            [self stringForIndexPaths:indexPaths],
            [self stringForAnimation:animation],
            [self stringForQueue]];
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.operationStrings addObject:[self stringForDeleteRowsAtIndexPaths:indexPaths withRowAnimation:animation]];
}

- (NSString *)stringForDeleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    return [NSString stringWithFormat:@"deleteRowsAtIndexPaths:[%@] withRowAnimation:[%@] on %@",
            [self stringForIndexPaths:indexPaths],
            [self stringForAnimation:animation],
            [self stringForQueue]];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.operationStrings addObject:[self stringForReloadRowsAtIndexPaths:indexPaths withRowAnimation:animation]];
}

- (NSString *)stringForReloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    return [NSString stringWithFormat:@"reloadRowsAtIndexPaths:[%@] withRowAnimation:[%@] on %@",
            [self stringForIndexPaths:indexPaths],
            [self stringForAnimation:animation],
            [self stringForQueue]];
}

- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    [self.operationStrings addObject:[self stringForMoveRowAtIndexPath:indexPath toIndexPath:newIndexPath]];
}


- (NSString *)stringForMoveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    return [NSString stringWithFormat:@"moveRowAtIndexPath:[%@] toIndexPath:[%@] on %@",
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

- (NSString *)stringForQueue
{
    return [NSString stringWithUTF8String:dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)];
}

@end
