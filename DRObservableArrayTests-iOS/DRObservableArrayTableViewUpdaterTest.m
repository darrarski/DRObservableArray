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

@interface DRObservableArrayTableViewUpdaterTest : XCTestCase

@property (nonatomic, strong) DRObservableArrayTableViewUpdater *sut;
@property (nonatomic, strong) id <DRObservableArray, DRObservableMutableArray> collection;

@end

@implementation DRObservableArrayTableViewUpdaterTest

- (void)setUp
{
    [super setUp];
    ObservableArrayTableViewUpdaterTableViewBlock tableViewBlock = ^UITableView * {
        return nil;
    };
    ObservableArrayTableViewUpdaterSectionBlock sectionBlock = ^NSUInteger {
        return 0;
    };
    self.sut = [[DRObservableArrayTableViewUpdater alloc] initWithTableViewBlock:tableViewBlock
                                                                    sectionBlock:sectionBlock];
    self.collection = [[DRGenericObservableArray alloc] init];
    [self.collection setObjects:@[@"A", @"B", @"C", @"D", @"E", @"F"]];
    [self.collection.observers addObserver:self.sut];
}

- (void)tearDown
{
    self.sut = nil;
    self.collection = nil;
    [super tearDown];
}

- (void)testExample
{
    // TODO:
    XCTAssert(true, @"TEST");
}

@end
