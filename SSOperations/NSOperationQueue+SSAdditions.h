//
//  NSOperationQueue+SSAdditions.h
//  SSOperations
//
//  Created by Jonathan Hersh on 8/30/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSBlockOperation.h"

@interface NSOperationQueue (SSAdditions)

#pragma mark - Constructors

/**
 * Construct an NSOperationQueue that runs serially with a maximum of one concurrent operation.
 */
+ (instancetype) ss_serialOperationQueue;

/**
 * Construct an NSOperationQueue that runs with the system-provided maximum number of
 * concurrent operations.
 */
+ (instancetype) ss_concurrentMaxOperationQueue;

/**
 * Construct an NSOperationQueue with the specified number of concurrent operations.
 */
+ (instancetype) ss_concurrentQueueWithConcurrentOperations:(NSUInteger)operationCount;

#pragma mark - Operations

/**
 * Enqueue an `SSBlockOperation` with the specified operation block.
 */
- (void) ss_addBlockOperationWithBlock:(SSBlockOperationBlock)block;

@end
