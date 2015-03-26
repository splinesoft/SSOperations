//
//  SSOperationsTests.m
//  SSOperationsTests
//
//  Created by Jonathan Hersh on 8/15/14.
//  Copyright (c) 2014 Splinesoft. All rights reserved.
//

@import XCTest;
#import <SSOperations.h>

@interface SSOperationsTests : XCTestCase

@end

@implementation SSOperationsTests

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
    
    XCTestExpectation *submitExpectation = [self expectationWithDescription:@"Single queue submit"];
    
    [singleQueue ss_addBlockOperationWithBlock:^(SSBlockOperation *operation) {
        XCTAssertFalse([NSThread isMainThread], @"Should not run on main thread");
        [submitExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testSerialQueue
{
    NSOperationQueue *singleQueue = [NSOperationQueue ss_serialOperationQueue];
    NSDate *expectedEndDate = [[NSDate date] dateByAddingTimeInterval:1];
    
    XCTestExpectation *serialExpectation = [self expectationWithDescription:@"Serial Queue"];
    
    [singleQueue ss_addBlockOperationWithBlock:^(SSBlockOperation *operation) {
        sleep(2);
    }];
    
    [singleQueue ss_addBlockOperationWithBlock:^(SSBlockOperation *operation) {
        XCTAssertTrue([[NSDate date] compare:expectedEndDate] == NSOrderedDescending,
                      @"Should have run serially");
        [serialExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:8 handler:nil];
}

@end
