//
//  SSViewController.m
//  SSOperationsExample
//
//  Created by Jonathan Hersh on 8/30/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSViewController.h"
#import "SSOperations.h"

@interface SSViewController ()

@end

@implementation SSViewController {
    NSOperationQueue *serialQueue;
    NSOperationQueue *concurrentQueue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    serialQueue = [NSOperationQueue ss_serialOperationQueue];
    concurrentQueue = [NSOperationQueue ss_concurrentMaxOperationQueue];
    
    NSLog(@"On this day were born two beautiful queues:\n%@\n%@",
          [serialQueue name],
          [concurrentQueue name]);
	
    // Run some operations!
    for( NSUInteger i = 0; i < 10; i++ ) {
        [serialQueue ss_addBlockOperationWithBlock:^(SSBlockOperation *operation) {
            for( NSUInteger j = 0; j < 100; j++ )
                NSLog(@"Serial #%i: %i", i, j);
        }];
        
        [concurrentQueue ss_addBlockOperationWithBlock:^(SSBlockOperation *operation) {
            for( NSUInteger j = 0; j < 100; j++ )
                NSLog(@"Concurrent #%i: %i", i, j);
        }];
    }
}

@end
