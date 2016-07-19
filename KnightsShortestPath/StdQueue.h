//
//  StdQueue.h
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@interface StdQueue : NSObject

@property(nonatomic, readonly) BOOL empty;
@property(nonatomic, readonly) NSUInteger size;
@property(nonatomic, readonly) id front;
@property(nonatomic, readonly) id back;

- (void)enqueue:(id)object;
- (id)dequeue;

@end
