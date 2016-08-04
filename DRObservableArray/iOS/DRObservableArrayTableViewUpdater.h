//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRObservableArrayObserver.h"

typedef UITableView *(^ObservableArrayTableViewUpdaterTableViewBlock)();
typedef NSUInteger (^ObservableArrayTableViewUpdaterSectionBlock)();

@interface DRObservableArrayTableViewUpdater : NSObject <DRObservableArrayObserver>

- (instancetype)initWithTableViewBlock:(ObservableArrayTableViewUpdaterTableViewBlock)tableViewBlock
                          sectionBlock:(ObservableArrayTableViewUpdaterSectionBlock)sectionBlock;

@end
