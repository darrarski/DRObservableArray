//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewMock : UITableView

@property (nonatomic, strong, readonly) NSMutableArray <NSString *> *operationStrings;

- (NSString *)stringForBeginUpdates;
- (NSString *)stringForEndUpdates;
- (NSString *)stringForReloadData;
- (NSString *)stringForInsertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (NSString *)stringForDeleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (NSString *)stringForReloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (NSString *)stringForMoveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;

@end
