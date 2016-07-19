//
//  Knight.m
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import "Knight.h"

@implementation Move

- (instancetype) initWithRows:(NSInteger) rows andCols:(NSInteger) cols {
    self = [super init];
    if (self) {
        self.rows = rows;
        self.cols = cols;
    }
    return self;
}

@end

@implementation Knight

- (instancetype) init {
    self = [super init];
    if (self) {
        self.availableMoves = [NSArray arrayWithObjects:
                               [[Move alloc] initWithRows:1 andCols:2],
                               [[Move alloc] initWithRows:-1 andCols:2],
                               [[Move alloc] initWithRows:1 andCols:-2],
                               [[Move alloc] initWithRows:-1 andCols:-2],
                               [[Move alloc] initWithRows:2 andCols:1],
                               [[Move alloc] initWithRows:-2 andCols:1],
                               [[Move alloc] initWithRows:2 andCols:-1],
                               [[Move alloc] initWithRows:-2 andCols:-1], nil];
    }
    return self;
}

- (NSArray*) getPssibleSquaresForRow:(NSInteger)row
                              andCol:(NSInteger)col {
    Square *currentSquare = [[Square alloc] initWithRow:row
                                                 andCol:col];
    NSMutableArray *possibleMoves = [NSMutableArray array];
    for (Move *move in self.availableMoves) {
        if ([currentSquare isValidMoveByRows:move.rows
                                     andCols:move.cols]) {
            [possibleMoves addObject: [currentSquare squareMovedBy:move.rows
                                                           andCols:move.cols]];
        }
    }
    return possibleMoves;
}

@end
