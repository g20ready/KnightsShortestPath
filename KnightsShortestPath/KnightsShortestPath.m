//
//  KnightsShortestPath.m
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import "KnightsShortestPath.h"

@implementation KnightsShortestPath
    
- (void) findShortestPathFrom:(Square *) start
                           to:(Square *) end
                        piece:(id <Piece>) piece
            withMaxMovesCount:(NSInteger) maxMovesCount
           withPathFoundBlock:(pathFoundBlock) pathFoundBlock
              completionBlock:(completionBlock) completionBlock {
    
    StdQueue *queue = [[StdQueue alloc] init];
    
    NSMutableArray *startSolution = [NSMutableArray array];
    [startSolution addObject:start];
    
    [queue enqueue:startSolution];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while ([queue size] != 0) {
            NSMutableArray *currentSolution = [queue dequeue];
            Square *currentSquare = [currentSolution lastObject];
            
            NSMutableArray *visited = [NSMutableArray arrayWithArray:currentSolution];
            
            if (currentSquare.row == end.row && currentSquare.col == end.col) {
                dispatch_sync(dispatch_get_main_queue(), ^ {
                    pathFoundBlock(currentSolution);
                });
                continue;
            }
            
            for (Square *adjacentSquare in [piece getPssibleSquaresForRow:currentSquare.row
                                                                   andCol:currentSquare.col]) {
                if (![self isSquare:adjacentSquare inVisited:visited]) {
                    //CurrentSolution Contains number of blocks
                    //A move is from block to block, so 1 move is 2 blocks
                    //So we should add 1 to maxMovesCount so that is is actually moves
                    if ([currentSolution count] < maxMovesCount + 1) {
                        NSMutableArray *branch = [NSMutableArray arrayWithArray:currentSolution];
                        [branch addObject:adjacentSquare];
                        [visited addObject:adjacentSquare];
                        [queue enqueue:branch];
                    }
                }
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^ {
            completionBlock();
        });
    });
}
    
- (BOOL) isSquare:(Square *) square inVisited:(NSArray *) visited {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.row == %ld AND self.col == %ld", square.row, square.col];
    return [[visited filteredArrayUsingPredicate:predicate] count] > 0;
}
    
@end
