//
//  KnightsShortestPath.m
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import "KnightsShortestPath.h"

@implementation KnightsShortestPath

- (NSArray*) findShortestPathFrom:(Square *)start
                               to:(Square *)end
                            piece:(id<Piece>)piece
                withMaxMovesCount:(NSInteger) maxMovesCount {
    NSMutableArray *availableSolutions = [NSMutableArray array];
    
    StdQueue *queue = [[StdQueue alloc] init];
    
    NSMutableArray *startSolution = [NSMutableArray array];
    [startSolution addObject:start];
    
    [queue enqueue:startSolution];
    
    while ([queue size] != 0) {
        NSMutableArray *currentSolution = [queue dequeue];
        Square *currentSquare = [currentSolution lastObject];
        
        NSMutableArray *visited = [NSMutableArray arrayWithArray:currentSolution];
        
        if (currentSquare.row == end.row && currentSquare.col == end.col) {
            [availableSolutions addObject:currentSolution];
            continue;
        }
        
        for (Square *adjacentSquare in [piece getPssibleSquaresForRow:currentSquare.row
                                                               andCol:currentSquare.col]) {
            if (![self isSquare:adjacentSquare inVisited:visited]) {
                if ([currentSolution count] < maxMovesCount) {
                    NSMutableArray *branch = [NSMutableArray arrayWithArray:currentSolution];
                    [branch addObject:adjacentSquare];
                    [visited addObject:adjacentSquare];
                    [queue enqueue:branch];
                }
            }
        }
    }
    return availableSolutions;
}

- (BOOL) isSquare:(Square *) square inVisited:(NSArray *) visited {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.row == %ld AND self.col == %ld", square.row, square.col];
    return [[visited filteredArrayUsingPredicate:predicate] count] > 0;
}

@end
