//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRObservableArrayObserver.h"

typedef UITableView *(^ObservableArrayTableViewUpdaterTableViewBlock)();
typedef NSUInteger (^ObservableArrayTableViewUpdaterSectionBlock)();

/**
 * `DRObservableArrayTableViewUpdater` is a `DRObservableArrayObserver` that updates
 * `UITableView` automatically whenever collection changes.
 */
@interface DRObservableArrayTableViewUpdater : NSObject <DRObservableArrayObserver>

/**
 * Initializes observer with given table view and section blocks
 *
 * @param tableViewBlock A block that returns `UITableView` instance
 * @param sectionBlock A block that returns table view's section index
 * @return The newly-initialized observer
 */
- (instancetype)initWithTableViewBlock:(ObservableArrayTableViewUpdaterTableViewBlock)tableViewBlock
                          sectionBlock:(ObservableArrayTableViewUpdaterSectionBlock)sectionBlock;

@end
