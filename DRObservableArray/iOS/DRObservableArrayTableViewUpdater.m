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

- (void)observableArrayWillChangeObjects:(id <DRObservableArray>)array
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
    });
}

- (void)observableArrayDidChangeObjects:(id <DRObservableArray>)array
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView endUpdates];
    });
}

- (void)observableArrayDidSetObjects:(id <DRObservableArray>)array
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)observableArray:(id <DRObservableArray>)array didInsertObject:(id)object atIndex:(NSUInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView insertRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

- (void)observableArray:(id <DRObservableArray>)array didRemoveObject:(id)object atIndex:(NSUInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView deleteRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

- (void)observableArray:(id <DRObservableArray>)array didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index withObject:(id)newObject
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

- (void)observableArray:(id <DRObservableArray>)array didMoveObject:(id)object fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView moveRowAtIndexPath:[self tableViewIndexPathFromObjectIndex:fromIndex]
                               toIndexPath:[self tableViewIndexPathFromObjectIndex:toIndex]];
    });
}

@end
