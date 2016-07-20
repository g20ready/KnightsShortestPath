//
//  ShortestPathTableViewCell.m
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 20/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import "ShortestPathTableViewCell.h"

@implementation ShortestPathTableViewCell

+ (UINib *) nib {
    return [UINib nibWithNibName:NSStringFromClass([ShortestPathTableViewCell class]) bundle:nil];
}

+ (NSString *) reuseIdentifier {
    return @"shortestPathTableViewCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
