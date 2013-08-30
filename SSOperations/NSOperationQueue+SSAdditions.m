//
//  NSOperationQueue+SSAdditions.m
//  SSOperations
//
//  Created by Jonathan Hersh on 8/30/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSOperations.h"

@implementation NSOperationQueue (SSAdditions)

+ (instancetype)serialOperationQueue {
    return [self operationQueueWithConcurrentOperations:1];
}

+ (instancetype)concurrentMaxOperationQueue {
    return [self operationQueueWithConcurrentOperations:NSOperationQueueDefaultMaxConcurrentOperationCount];
}

+ (instancetype)operationQueueWithConcurrentOperations:(NSUInteger)operationCount {
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue setMaxConcurrentOperationCount:operationCount];
    
    return queue;
}

- (void) addSSBlockOperationWithBlock:(SSBlockOperationBlock)block {
    [self addOperation:[SSBlockOperation operationWithBlock:block]];
}

@end
