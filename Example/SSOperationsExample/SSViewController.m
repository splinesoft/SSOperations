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
    
    serialQueue = [NSOperationQueue serialOperationQueue];
    concurrentQueue = [NSOperationQueue concurrentMaxOperationQueue];
	
    // Run some operations!
    for( NSUInteger i = 0; i < 10; i++ ) {
        [serialQueue addSSBlockOperationWithBlock:^(SSBlockOperation *operation) {
            for( NSUInteger j = 0; j < 100; j++ )
                NSLog(@"Serial #%i: %i", i, j);
        }];
        
        [concurrentQueue addSSBlockOperationWithBlock:^(SSBlockOperation *operation) {
            for( NSUInteger j = 0; j < 100; j++ )
                NSLog(@"Concurrent #%i: %i", i, j);
        }];
    }
}

@end
