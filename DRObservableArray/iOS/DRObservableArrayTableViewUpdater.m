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
        _queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
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

- (void)addOperation:(void (^)())block
{
    dispatch_async(self.queue, ^{
        dispatch_sync(dispatch_get_main_queue(), block);
    });
}

#pragma mark - ObservableArrayObserver

- (void)observableArrayWillChangeObjects:(id <DRObservableArray>)array
{
    UITableView *tableView = self.tableView;
    [self addOperation:^{
        [tableView beginUpdates];
    }];
}

- (void)observableArrayDidChangeObjects:(id <DRObservableArray>)array
{
    UITableView *tableView = self.tableView;
    [self addOperation:^{
        [tableView endUpdates];
    }];
}

- (void)observableArrayDidSetObjects:(id <DRObservableArray>)array
{
    UITableView *tableView = self.tableView;
    [self addOperation:^{
        [tableView reloadData];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didInsertObject:(id)object atIndex:(NSUInteger)index
{
    UITableView *tableView = self.tableView;
    NSIndexPath *indexPath = [self tableViewIndexPathFromObjectIndex:index];
    [self addOperation:^{
        [tableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didRemoveObject:(id)object atIndex:(NSUInteger)index
{
    UITableView *tableView = self.tableView;
    NSIndexPath *indexPath = [self tableViewIndexPathFromObjectIndex:index];
    [self addOperation:^{
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index withObject:(id)newObject
{
    UITableView *tableView = self.tableView;
    NSIndexPath *indexPath = [self tableViewIndexPathFromObjectIndex:index];
    [self addOperation:^{
        [tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)observableArray:(id <DRObservableArray>)array didMoveObject:(id)object fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    UITableView *tableView = self.tableView;
    NSIndexPath *fromIndexPath = [self tableViewIndexPathFromObjectIndex:fromIndex];
    NSIndexPath *toIndexPath = [self tableViewIndexPathFromObjectIndex:toIndex];
    [self addOperation:^{
        [tableView moveRowAtIndexPath:fromIndexPath
                          toIndexPath:toIndexPath];
    }];
}

@end
