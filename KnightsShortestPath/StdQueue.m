//
//  StdQueue.m
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import "StdQueue.h"

@interface StdQueue ()

@property(nonatomic, strong) NSMutableArray* storage;

@end

@implementation StdQueue

#pragma mark NSObject

- (id)init
{
    if (self = [super init]) {
        _storage = [NSMutableArray array];
    }
    return self;
}

#pragma mark StdQueue

- (BOOL)empty
{
    return self.storage.count == 0;
}

- (NSUInteger)size
{
    return self.storage.count;
}

- (id)front
{
    return self.storage.firstObject;
}

- (id)back
{
    return self.storage.lastObject;
}

- (void)enqueue:(id)object
{
    [self.storage addObject:object];
}

- (id)dequeue
{
    id firstObject = nil;
    if (!self.empty) {
        firstObject  = self.storage.firstObject;
        [self.storage removeObjectAtIndex:0];
    }
    return firstObject;
}

@end
