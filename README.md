SSOperations
=============

![](http://cocoapod-badges.herokuapp.com/v/SSOperations/badge.png) &nbsp; ![](http://cocoapod-badges.herokuapp.com/p/SSOperations/badge.png) &nbsp; [![Build Status](https://travis-ci.org/splinesoft/SSOperations.png?branch=master)](https://travis-ci.org/splinesoft/SSOperations)

Handy `NSOperationQueue` and `NSBlockOperation` helpers.

`SSOperations` powers various operations in my app [MUDRammer - a modern MUD client for iPhone and iPad](https://itunes.apple.com/us/app/mudrammer-a-modern-mud-client/id597157072?mt=8).

## Install

Install with [Cocoapods](http://cocoapods.org). Add to your podfile:

```
pod 'SSOperations', :head # YOLO
```

## SSBlockOperation & SSBlockOperationBlock

A simple subclass of `NSBlockOperation` that is passed itself as input when executed.

The primary advantage is that you can inspect, at run-time, whether the operation has been canceled and if so, clean up and exit appropriately.

```objc
SSBlockOperationBlock anOperationBlock = ^(SSBlockOperation *operation) {
	if( [operation isCancelled] )
		return;
		
	// Do some stuff…
	
	if( [operation isCancelled] )
		return;
	
	// Do some more stuff...
};

// Submit this operation to a queue for execution.
[myOperationQueue addSSBlockOperationWithBlock:anOperationBlock];
```

## NSOperationQueue+SSAdditions.h

A handy way to create an `NSOperationQueue` and submit `SSBlockOperationBlock`s for execution.

```objc
// An operation queue that runs operations serially.
NSOperationQueue *serialQueue = [NSOperationQueue serialOperationQueue];

// An operation queue that runs up to 3 operations concurrently.
NSOperationQueue *threeOperationQueue = [NSOperationQueue operationQueueWithConcurrentOperations:3];

// An operation queue that runs as many concurrent operations as the system deems appropriate.
NSOperationQueue *concurrentQueue = [NSOperationQueue concurrentMaxOperationQueue];

// Submit an `SSBlockOperationBlock` for processing.
[anOperationQueue addSSBlockOperationWithBlock:anOperationBlock];
```

## Thanks!

`SSOperations` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))
