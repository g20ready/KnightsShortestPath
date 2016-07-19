//
//  Square.m
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import "Square.h"

@implementation Square

- (instancetype) initWithRow:(NSInteger) row andCol:(NSInteger) col {
    self = [super init];
    if (self) {
        self.row = row;
        self.col = col;
    }
    return self;
}

- (instancetype) initWithChessRow:(char)row andNotCol:(char)col {
    self = [super init];
    if (self) {
        self.row = (NSInteger) row - MinRowChar;
        self.col = (NSInteger) col - MinColChar;
    }
    return self;
}

- (Square *) squareMovedBy:(NSInteger)moveByRows
                   andCols:(NSInteger)moveByCols {
    return [[Square alloc] initWithRow:self.row + moveByRows
                                andCol:self.col + moveByCols];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%c%c", (char)(MinRowChar+self.row), (char)(MinColChar+self.col)];
}

- (BOOL) isValidMoveByRows:(NSInteger)moveByRows
                   andCols:(NSInteger)moveByCols {
    return
    self.row + moveByRows >= 0 &&
    self.row + moveByRows < MaxRows &&
    self.col + moveByCols >=0 &&
    self.col + moveByCols < MaxCols;
}

@end
