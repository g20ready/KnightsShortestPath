//
//  ShortestPathTableViewCell.h
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 20/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortestPathTableViewCell : UITableViewCell

+ (UINib *) nib;

+ (NSString *) reuseIdentifier;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
