//
//  DRObservableArrayTableViewUpdaterTest.m
//  DRObservableArrayExample
//
//  Created by Dariusz Rybicki on 04/08/16.
//  Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DRObservableArrayTableViewUpdater.h"
#import "DRObservableArray.h"
#import "DRObservableMutableArray.h"
#import "DRGenericObservableArray.h"
#import "UITableViewMock.h"

@interface DRObservableArrayTableViewUpdaterTest : XCTestCase

@property (nonatomic, strong) DRObservableArrayTableViewUpdater *sut;
@property (nonatomic, strong) id <DRObservableArray, DRObservableMutableArray> collection;
@property (nonatomic, strong) UITableViewMock *tableView;
@property (nonatomic, assign) NSUInteger sectionIndex;

@end

@implementation DRObservableArrayTableViewUpdaterTest

- (void)setUp
{
    [super setUp];

    self.collection = [[DRGenericObservableArray alloc] init];
    [self.collection setObjects:@[@"A", @"B", @"C", @"D", @"E", @"F"]];
    self.tableView = [[UITableViewMock alloc] init];
    self.sectionIndex = 3;

    __weak typeof(self) welf = self;
    ObservableArrayTableViewUpdaterTableViewBlock tableViewBlock = ^UITableView * {
        return welf.tableView;
    };
    ObservableArrayTableViewUpdaterSectionBlock sectionBlock = ^NSUInteger {
        return welf.sectionIndex;
    };
    self.sut = [[DRObservableArrayTableViewUpdater alloc] initWithTableViewBlock:tableViewBlock
                                                                    sectionBlock:sectionBlock];

    [self.collection.observers addObserver:self.sut];
}

- (void)tearDown
{
    self.sut = nil;
    self.collection = nil;
    self.tableView = nil;
    self.sectionIndex = 0;
    [super tearDown];
}

- (void)testShouldInsertRowWhenInsertingObject
{
    [self.collection insertObject:@"G" atIndex:6];
    NSArray *expectedOperationStrings = @[
        [self.tableView stringForBeginUpdates],
        [self.tableView stringForInsertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:self.sectionIndex]] withRowAnimation:UITableViewRowAnimationAutomatic],
        [self.tableView stringForEndUpdates]
    ];
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssertEqualObjects(self.tableView.operationStrings, expectedOperationStrings, @"Should insert row when inserting object");
    });
}

- (void)testShouldDeleteRowWhenRemovingObject
{
    [self.collection removeObjectAtIndex:4];
    NSArray *expectedOperationStrings = @[
        [self.tableView stringForBeginUpdates],
        [self.tableView stringForDeleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:self.sectionIndex]] withRowAnimation:UITableViewRowAnimationAutomatic],
        [self.tableView stringForEndUpdates]
    ];
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssertEqualObjects(self.tableView.operationStrings, expectedOperationStrings, @"Should delete row when removing object");
    });
}

- (void)testShouldReloadDataWhenSettingObjects
{
    [self.collection setObjects:@[@"1", @"2", @"3"]];
    NSArray *expectedOperationStrings = @[
        [self.tableView stringForBeginUpdates],
        [self.tableView stringForReloadData],
        [self.tableView stringForEndUpdates]
    ];
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssertEqualObjects(self.tableView.operationStrings, expectedOperationStrings, @"Should reload data when setting objects");
    });
}

- (void)testShouldReloadRowWhenReplacingObject
{
    [self.collection replaceObjectAtIndex:2 withObject:@"0"];
    NSArray *expectedOperationStrings = @[
        [self.tableView stringForBeginUpdates],
        [self.tableView stringForReloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:self.sectionIndex]] withRowAnimation:UITableViewRowAnimationAutomatic],
        [self.tableView stringForEndUpdates]
    ];
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssertEqualObjects(self.tableView.operationStrings, expectedOperationStrings, @"Should reload row when replacing object");
    });
}

- (void)testShouldMoveRowWhenMovingObject
{
    [self.collection moveObjectAtIndex:3 toIndex:1];
    NSArray *expectedOperationStrings = @[
        [self.tableView stringForBeginUpdates],
        [self.tableView stringForMoveRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:self.sectionIndex] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:self.sectionIndex]],
        [self.tableView stringForEndUpdates]
    ];
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssertEqualObjects(self.tableView.operationStrings, expectedOperationStrings, @"Should move row when moving object");
    });
}

- (void)testShouldMoveTwoRowsWhenExchagingObjects
{
    [self.collection exchangeObjectAtIndex:2 withObjectAtIndex:5];
    NSArray *expectedOperationStrings = @[
        [self.tableView stringForBeginUpdates],
        [self.tableView stringForMoveRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:self.sectionIndex] toIndexPath:[NSIndexPath indexPathForRow:5 inSection:self.sectionIndex]],
        [self.tableView stringForEndUpdates],
        [self.tableView stringForBeginUpdates],
        [self.tableView stringForMoveRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:self.sectionIndex] toIndexPath:[NSIndexPath indexPathForRow:2 inSection:self.sectionIndex]],
        [self.tableView stringForEndUpdates]
    ];
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssertEqualObjects(self.tableView.operationStrings, expectedOperationStrings, @"Should move two rows when exchanging objects");
    });
}

@end
