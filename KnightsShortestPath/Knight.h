//
//  Knight.h
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Square.h"

@interface Move : NSObject

@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) NSInteger cols;

- (instancetype) initWithRows:(NSInteger) rows andCols:(NSInteger) cols;

@end

@protocol Piece <NSObject>

@required
- (NSArray*) getPssibleSquaresForRow:(NSInteger)row
                              andCol:(NSInteger)col;

@end


@interface Knight : NSObject <Piece>

@property (nonatomic, strong) NSArray *availableMoves;

@end
