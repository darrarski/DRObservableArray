//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "DRObservableArrayTableViewUpdater.h"

@interface DRObservableArrayTableViewUpdater ()

@property (nonatomic, copy, readonly) ObservableArrayTableViewUpdaterTableViewBlock tableViewBlock;
@property (nonatomic, copy, readonly) ObservableArrayTableViewUpdaterSectionBlock sectionBlock;

@end

@implementation DRObservableArrayTableViewUpdater

- (instancetype)initWithTableViewBlock:(ObservableArrayTableViewUpdaterTableViewBlock)tableViewBlock
                          sectionBlock:(ObservableArrayTableViewUpdaterSectionBlock)sectionBlock
{
    if (self = [super init]) {
        _tableViewBlock = tableViewBlock;
        _sectionBlock = sectionBlock;
    }
    return self;
}

#pragma mark - Helpers

- (UITableView *)tableView
{
    return self.tableViewBlock ? self.tableViewBlock() : nil;
}

- (NSUInteger)section
{
    return self.sectionBlock ? self.sectionBlock() : 0;
}

- (NSIndexPath *)tableViewIndexPathFromObjectIndex:(NSUInteger)index
{
    return [NSIndexPath indexPathForRow:index inSection:self.section];
}

#pragma mark - ObservableArrayObserver

- (void)willChangeObjects
{
    [self.tableView beginUpdates];
}

- (void)didChangeObjects
{
    [self.tableView endUpdates];
}

- (void)didSetObjects
{
    [self.tableView reloadData];
}

- (void)didInsertObject:(id)object atIndex:(NSUInteger)index
{
    [self.tableView insertRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didRemoveObject:(id)object atIndex:(NSUInteger)index
{
    [self.tableView deleteRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];;
}

- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index
{
    [self.tableView reloadRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didMoveObject:(id)object fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    [self.tableView moveRowAtIndexPath:[self tableViewIndexPathFromObjectIndex:fromIndex]
                           toIndexPath:[self tableViewIndexPathFromObjectIndex:toIndex]];
}

@end
