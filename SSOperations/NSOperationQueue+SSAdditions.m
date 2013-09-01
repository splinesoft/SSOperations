//
//  NSOperationQueue+SSAdditions.m
//  SSOperations
//
//  Created by Jonathan Hersh on 8/30/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSOperations.h"

@implementation NSOperationQueue (SSAdditions)

+ (instancetype) ss_serialOperationQueue {
    return [self ss_concurrentQueueWithConcurrentOperations:1];
}

+ (instancetype) ss_concurrentMaxOperationQueue {
    return [self ss_concurrentQueueWithConcurrentOperations:NSOperationQueueDefaultMaxConcurrentOperationCount];
}

+ (instancetype) ss_concurrentQueueWithConcurrentOperations:(NSUInteger)operationCount {
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue setMaxConcurrentOperationCount:operationCount];
    
    return queue;
}

- (void) ss_addBlockOperationWithBlock:(SSBlockOperationBlock)block {
    [self addOperation:[SSBlockOperation operationWithBlock:block]];
}

@end
