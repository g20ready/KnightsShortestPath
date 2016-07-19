//
//  ViewController.m
//  KnightsShortestPath
//
//  Created by Marsel Xhaxho on 19/07/16.
//  Copyright © 2016 Marsel Xhaxho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)viewDidAppear:(BOOL)animated {
    [self initializeBoard];
}

- (IBAction)handleResetClicked:(id)sender {
    if (self.startView) {
        [self.startView setBackgroundColor:[self colorAtRow:self.startView.boardRow
                                                     andCol:self.startView.boardColumn
                                                    reverse:NO]];
    }
    if (self.endView) {
        [self.endView setBackgroundColor:[self colorAtRow:self.endView.boardRow
                                                     andCol:self.endView.boardColumn
                                                  reverse:NO]];
    }
    
    self.startView = nil;
    self.endView = nil;
    
    [self.calculateBarButtonItem setEnabled:NO];
}

- (IBAction)handleCalculateClicked:(id)sender {
    KnightsShortestPath *ksp = [[KnightsShortestPath alloc] init];
    
    Square *startSquare = [[Square alloc] initWithRow:self.startView.boardRow andCol:self.startView.boardColumn];
    
    Square *endSquare = [[Square alloc] initWithRow:self.endView.boardRow andCol:self.endView.boardColumn];
    
    self.solutions = [ksp findShortestPathFrom:startSquare to:endSquare piece:[[Knight alloc] init] withMaxMovesCount:3];
    
    [self.resultsTableView reloadData];
    
    if ([self.solutions count] == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Finished Calculating" message:@"No Path found" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - functions

- (void) initialize {
    [self.calculateBarButtonItem setEnabled:NO];
    self.title = @"Select Start Square";
}

- (void) initializeBoard {
    [self.boardContainerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    CGFloat viewSide = self.boardContainerView.frame.size.width / 8;
    UIView* view = nil;
    for (NSInteger i=0; i<8; i++) {
        for (NSInteger j=0; j<8; j++) {
            view = [[UIView alloc] initWithFrame:CGRectMake(viewSide*j, viewSide * i, viewSide, viewSide)];
            view.boardRow = i;
            view.boardColumn = j;
            
            [view setBackgroundColor:[self colorAtRow:i
                                               andCol:j
                                              reverse:NO]];
            
            UITapGestureRecognizer *tap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
            [view addGestureRecognizer:tap];
            view.userInteractionEnabled = YES;
            
            [self.boardContainerView addSubview:view];
        }
    }
}

- (UIColor*) colorAtRow:(NSInteger) row andCol:(NSInteger) col reverse:(BOOL) reversed {
    BOOL value = reversed ? row % 2 != col % 2 : row % 2 == col % 2;
    return value ? [UIColor whiteColor] : [UIColor blackColor];;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    if (!self.startView) {
        self.startView = recognizer.view;
        [self addLabelWithText:@"S" toView:self.startView];
        self.title = @"Select End Square";
    }else if (recognizer.view != self.startView) {
        if (self.endView) {
            [self.endView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
        }
        self.endView = recognizer.view;
        [self addLabelWithText:@"E" toView:self.endView];
        self.calculateBarButtonItem.enabled = YES;
        self.title = @"Hit Calculate!";
    }
}

- (void) addLabelWithText:(NSString *) value toView:(UIView *) view{
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [self colorAtRow:view.boardRow
                                andCol:view.boardColumn
                               reverse:YES];
    label.text = value;
    [view addSubview:label];
}


#pragma mark - TableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.solutions ? [self.solutions count] : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSArray *moves = [self.solutions objectAtIndex:indexPath.row];
    
    __block NSString *description = @"";
    [moves enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Square *square = (Square*)obj;
        description = [description stringByAppendingString:[NSString stringWithFormat:@"%@, ", square]];
    }];
    
    cell.textLabel.text = description;
    
    return cell;
}

@end
