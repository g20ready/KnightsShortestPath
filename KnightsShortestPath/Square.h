//
//  Square.h
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import <Foundation/Foundation.h>

static char const MinRowChar = 'A';
static char const MinColChar = '1';

static NSInteger const MaxRows = 8;
static NSInteger const MaxCols = 8;

@interface Square : NSObject

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger col;

- (instancetype) initWithRow:(NSInteger) row
                      andCol:(NSInteger) col;

- (Square *) squareMovedBy:(NSInteger)moveByRows
                   andCols:(NSInteger) moveByCols;

- (BOOL) isValidMoveByRows:(NSInteger) moveByRows
                   andCols:(NSInteger) moveByCols;

@end
