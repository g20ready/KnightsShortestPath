//
//  KnightsShortestPath.h
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StdQueue.h"
#import "Square.h"
#import "Knight.h"

@interface KnightsShortestPath : NSObject
    
    typedef void (^pathFoundBlock)(NSArray*);
    typedef void (^completionBlock)();
    
- (void) findShortestPathFrom:(Square *) start
                           to:(Square *) end
                        piece:(id <Piece>) piece
            withMaxMovesCount:(NSInteger) maxMovesCount
           withPathFoundBlock:(pathFoundBlock) pathFoundBlock
              completionBlock:(completionBlock) completionBlock;
    
@end
