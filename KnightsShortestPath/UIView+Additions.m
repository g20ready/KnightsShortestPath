//
//  UIViewAdditions.m
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import "UIView+Additions.h"

NSString *const BOARD_ROW_KEY = @"boardRow";
NSString *const BOARD_COLUMN_KEY = @"boardColumn";

@implementation UIView (Additions)


@dynamic boardRow;
@dynamic boardColumn;

- (void)setBoardRow:(NSInteger)boardRow {
    NSNumber *val = @(boardRow);
    objc_setAssociatedObject(self, (__bridge const void*)(BOARD_ROW_KEY), val, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)boardRow {
    NSNumber *val = objc_getAssociatedObject(self, (__bridge const void*)BOARD_ROW_KEY);
    return [val integerValue];
}

- (void)setBoardColumn:(NSInteger)boardColumn {
    NSNumber *val = @(boardColumn);
    objc_setAssociatedObject(self, (__bridge const void*)(BOARD_COLUMN_KEY), val, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)boardColumn {
    NSNumber *val = objc_getAssociatedObject(self, (__bridge const void*)BOARD_COLUMN_KEY);
    return [val integerValue];
}

@end
