//
//  NSOperationQueue+SSAdditions.m
//  SSOperations
//
//  Created by Jonathan Hersh on 8/30/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSOperations.h"

@implementation NSOperationQueue (SSAdditions)

+ (instancetype) SSSerialOperationQueue {
    return [self SSConcurrentQueueWithConcurrentOperations:1];
}

+ (instancetype) SSConcurrentMaxOperationQueue {
    return [self SSConcurrentQueueWithConcurrentOperations:NSOperationQueueDefaultMaxConcurrentOperationCount];
}

+ (instancetype) SSConcurrentQueueWithConcurrentOperations:(NSUInteger)operationCount {
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue setMaxConcurrentOperationCount:operationCount];
    
    return queue;
}

- (void) SSAddBlockOperationWithBlock:(SSBlockOperationBlock)block {
    [self addOperation:[SSBlockOperation operationWithBlock:block]];
}

@end
