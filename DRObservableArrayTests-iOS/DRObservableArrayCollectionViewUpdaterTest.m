//
//  DRObservableArrayCollectionViewUpdaterTest.m
//  DRObservableArrayExample
//
//  Created by Dariusz Rybicki on 09/08/16.
//  Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DRObservableArrayCollectionViewUpdater.h"
#import "DRObservableMutableArray.h"
#import "UICollectionViewMock.h"
#import "DRGenericObservableArray.h"

@interface DRObservableArrayCollectionViewUpdaterTest : XCTestCase

@property (nonatomic, strong) DRObservableArrayCollectionViewUpdater *sut;
@property (nonatomic, strong) id <DRObservableArray, DRObservableMutableArray> collection;
@property (nonatomic, strong) UICollectionViewMock *collectionView;
@property (nonatomic, assign) NSUInteger sectionIndex;

@end

@implementation DRObservableArrayCollectionViewUpdaterTest

- (void)setUp
{
    [super setUp];

    self.collection = [[DRGenericObservableArray alloc] init];
    [self.collection setObjects:@[@"A", @"B", @"C", @"D", @"E", @"F"]];
    self.collectionView = [[UICollectionViewMock alloc] init];
    self.sectionIndex = 3;

    __weak typeof(self) welf = self;
    ObservableArrayCollectionViewUpdaterTableViewBlock collectionViewBlock = ^UICollectionView * {
        return welf.collectionView;
    };
    ObservableArrayCollectionViewUpdaterSectionBlock sectionBlock = ^NSUInteger {
        return welf.sectionIndex;
    };
    self.sut = [[DRObservableArrayCollectionViewUpdater alloc] initWithCollectionViewBlock:collectionViewBlock
                                                                              sectionBlock:sectionBlock];

    [self.collection.observers addObserver:self.sut];
}

- (void)tearDown
{
    self.sut = nil;
    self.collection = nil;
    self.collectionView = nil;
    self.sectionIndex = 0;
    [super tearDown];
}

- (void)testShouldInsertRowWhenInsertingObject
{
    [self.collection insertObject:@"G" atIndex:6];
    NSArray *expectedOperationStrings = @[
        [self.collectionView stringForInsertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:self.sectionIndex]]]
    ];
    XCTAssertEqualObjects(self.collectionView.operationStrings, expectedOperationStrings, @"Should insert item when inserting object");
}

- (void)testShouldDeleteRowWhenRemovingObject
{
    [self.collection removeObjectAtIndex:4];
    NSArray *expectedOperationStrings = @[
        [self.collectionView stringForDeleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:self.sectionIndex]]]
    ];
    XCTAssertEqualObjects(self.collectionView.operationStrings, expectedOperationStrings, @"Should delete item when removing object");
}

- (void)testShouldReloadDataWhenSettingObjects
{
    [self.collection setObjects:@[@"1", @"2", @"3"]];
    NSArray *expectedOperationStrings = @[
        [self.collectionView stringForReloadData]
    ];
    XCTAssertEqualObjects(self.collectionView.operationStrings, expectedOperationStrings, @"Should reload data when setting objects");
}

- (void)testShouldReloadRowWhenReplacingObject
{
    [self.collection replaceObjectAtIndex:2 withObject:@"0"];
    NSArray *expectedOperationStrings = @[
        [self.collectionView stringForReloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:self.sectionIndex]]]
    ];
    XCTAssertEqualObjects(self.collectionView.operationStrings, expectedOperationStrings, @"Should reload item when replacing object");
}

- (void)testShouldMoveRowWhenMovingObject
{
    [self.collection moveObjectAtIndex:3 toIndex:1];
    NSArray *expectedOperationStrings = @[
        [self.collectionView stringForMoveItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:self.sectionIndex]
                                              toIndexPath:[NSIndexPath indexPathForRow:1 inSection:self.sectionIndex]]
    ];
    XCTAssertEqualObjects(self.collectionView.operationStrings, expectedOperationStrings, @"Should move item when moving object");
}

- (void)testShouldMoveTwoRowsWhenExchagingObjects
{
    [self.collection exchangeObjectAtIndex:2 withObjectAtIndex:5];
    NSArray *expectedOperationStrings = @[
        [self.collectionView stringForMoveItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:self.sectionIndex]
                                              toIndexPath:[NSIndexPath indexPathForRow:5 inSection:self.sectionIndex]],
        [self.collectionView stringForMoveItemAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:self.sectionIndex]
                                              toIndexPath:[NSIndexPath indexPathForRow:2 inSection:self.sectionIndex]]
    ];
    XCTAssertEqualObjects(self.collectionView.operationStrings, expectedOperationStrings, @"Should move two items when exchanging objects");
}

@end