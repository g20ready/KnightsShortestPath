//
//  ViewController.h
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Square.h"
#import "Knight.h"
#import "KnightsShortestPath.h"
#import "ShortestPathTableViewCell.h"
#import "UIView+Additions.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *startView;
@property (nonatomic, strong) UIView *endView;

@property (nonatomic, strong) NSArray *markedViews;

@property (nonatomic, strong) NSMutableArray *solutions;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *calculateBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resetBarButtonItem;
@property (weak, nonatomic) IBOutlet UIView *boardContainerView;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;


#pragma mark - animations

typedef void(^animationBlock)(BOOL finished);

@end

