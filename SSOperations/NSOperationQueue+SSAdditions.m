//
//  NSOperationQueue+SSAdditions.m
//  SSOperations
//
//  Created by Jonathan Hersh on 8/30/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSOperations.h"

@interface NSOperationQueue (SSNaming)
+ (NSString *) defaultQueueName;
@end

@implementation NSOperationQueue (SSAdditions)

#pragma mark - Constructors

+ (instancetype) ss_serialOperationQueue {
    return [self ss_serialOperationQueueNamed:[self defaultQueueName]];
}

+ (instancetype)ss_serialOperationQueueNamed:(NSString *)name {
    return [self ss_concurrentQueueWithConcurrentOperations:1
                                                      named:name];
}

+ (instancetype) ss_concurrentMaxOperationQueue {
    return [self ss_concurrentMaxOperationQueueNamed:[self defaultQueueName]];
}

+ (instancetype)ss_concurrentMaxOperationQueueNamed:(NSString *)name {
    return [self ss_concurrentQueueWithConcurrentOperations:NSOperationQueueDefaultMaxConcurrentOperationCount
                                                      named:name];
}

+ (instancetype) ss_concurrentQueueWithConcurrentOperations:(NSUInteger)operationCount {
    return [self ss_concurrentQueueWithConcurrentOperations:operationCount
                                                      named:[self defaultQueueName]];
}

+ (instancetype)ss_concurrentQueueWithConcurrentOperations:(NSUInteger)operationCount
                                                     named:(NSString *)name {
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue setMaxConcurrentOperationCount:operationCount];
    [queue setName:name];
    
    return queue;
}

#pragma mark - Adding operations

- (void) ss_addBlockOperationWithBlock:(SSBlockOperationBlock)block {
    [self addOperation:[SSBlockOperation operationWithBlock:block]];
}

#pragma mark - naming

+ (NSString *)defaultQueueName {
    return [NSString stringWithFormat:@"%@-%f",
            NSStringFromClass(self),
            [[NSDate date] timeIntervalSince1970]];
}

@end
