//
//  SSOperationsTests.m
//  SSOperationsTests
//
//  Created by Jonathan Hersh on 8/15/14.
//  Copyright (c) 2014 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NSOperationQueue+SSAdditions.h>
#import <SSBlockOperation.h>
#import <XCTest+MXGSynchronizeTest.h>

@interface SSOperationsTests : XCTestCase

@end

@implementation SSOperationsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOperationQueuesInitialize
{
    NSOperationQueue *singleQueue = [NSOperationQueue ss_serialOperationQueue];
    XCTAssertNotNil(singleQueue, @"Single Queue should exist");
    XCTAssertEqual(singleQueue.maxConcurrentOperationCount, 1, @"Serial queue should be serial");
    
    NSOperationQueue *maxQueue = [NSOperationQueue ss_concurrentMaxOperationQueue];
    XCTAssertNotNil(maxQueue, @"Max queue should exist");
    XCTAssertEqual(maxQueue.maxConcurrentOperationCount, NSOperationQueueDefaultMaxConcurrentOperationCount, @"Max queue should be max concurrent");
    
    NSOperationQueue *threeQueue = [NSOperationQueue ss_concurrentQueueWithConcurrentOperations:3];
    XCTAssertNotNil(threeQueue, @"Three queue should exist");
    XCTAssertEqual(threeQueue.maxConcurrentOperationCount, 3, @"Threequeue should use 3 operations");
}

- (void)testOperationSubmit
{
    NSOperationQueue *singleQueue = [NSOperationQueue ss_serialOperationQueue];
    
    [XCTest mxg_synchronizeTest:^(BOOL *finished) {
        [singleQueue ss_addBlockOperationWithBlock:^(SSBlockOperation *operation) {
            XCTAssertFalse([NSThread isMainThread], @"Should not run on main thread");
            *finished = YES;
        }];
    }];
}

- (void)testSerialQueue
{
    NSOperationQueue *singleQueue = [NSOperationQueue ss_serialOperationQueue];
    NSDate *expectedEndDate = [[NSDate date] dateByAddingTimeInterval:1];
    
    [XCTest mxg_synchronizeTest:^(BOOL *finished) {
        [singleQueue ss_addBlockOperationWithBlock:^(SSBlockOperation *operation) {
            sleep(1);
        }];
        [singleQueue ss_addBlockOperationWithBlock:^(SSBlockOperation *operation) {
            XCTAssertTrue([[NSDate date] compare:expectedEndDate] == NSOrderedDescending,
                          @"Should have run serially");
            *finished = YES;
        }];
    }];
}

@end
