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
    
#pragma mark - Lifecycle
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.solutions = [NSMutableArray array];
    
    [self initialize];
    [self initializeTableView];
}
    
- (void)viewDidAppear:(BOOL)animated {
    [self initializeBoard];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
#pragma mark - Initialization
    
- (void) initialize {
    [self.calculateBarButtonItem setEnabled:NO];
    self.title = @"Select Start Square";
}
    
- (void) initializeTableView {
    self.resultsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.resultsTableView registerNib:[ShortestPathTableViewCell nib]
                forCellReuseIdentifier:[ShortestPathTableViewCell reuseIdentifier]];
}
    
- (void) initializeBoard {
    //Empty board
    [self.boardContainerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat notationMargin = 21.f;
    
    //We reserve 2 * notation margin
    CGFloat squareSide = (self.boardContainerView.frame.size.width - 2.f * notationMargin) / 8;
    
    UIView *view = nil;
    CGFloat x;
    CGFloat y;
    
    UILabel *notation;
    NSString *notationName;
    
    //We add column notations here
    for (NSInteger i=0; i<8; i++) {
        x = notationMargin + squareSide * i;
        y = 0;
        notationName = [NSString stringWithFormat:@"%c", [Square chessNotationForColumn:i]];
        notation = [self notationLabelWithFrame:CGRectMake(x, y, squareSide, notationMargin)
                                        andName:notationName];
        [self.boardContainerView addSubview:notation];
        y = notationMargin + 8 * squareSide;
        notation = [self notationLabelWithFrame:CGRectMake(x, y, squareSide, notationMargin)
                                        andName:notationName];
        [self.boardContainerView addSubview:notation];
    }
    
    //We add row notations here
    for (NSInteger i=0; i<8; i++) {
        x = 0;
        y = notationMargin + squareSide * i;
        notationName = [NSString stringWithFormat:@"%c", [Square chessNotationForRow:i]];
        notation = [self notationLabelWithFrame:CGRectMake(x, y, notationMargin, squareSide)
                                        andName:notationName];
        [self.boardContainerView addSubview:notation];
        x = notationMargin + 8 * squareSide;
        notation = [self notationLabelWithFrame:CGRectMake(x, y, notationMargin, squareSide)
                                        andName:notationName];
        [self.boardContainerView addSubview:notation];
    }
    
    //We add chess squares
    UITapGestureRecognizer *tapGestureRecognizer;
    for (NSInteger i=0; i<8;i++) {
        for (NSInteger j=0; j<8; j++) {
            x = notationMargin + squareSide * j;
            y = notationMargin + squareSide * i;
            view = [[UIView alloc] initWithFrame:CGRectMake(x, y, squareSide, squareSide)];
            view.boardRow = i;
            view.boardColumn = j;
            [view setBackgroundColor:[self colorAtRow:i andCol:j reverse:NO]];
            [self.boardContainerView addSubview:view];
            
            tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(handleSingleTap:)];
            [view addGestureRecognizer:tapGestureRecognizer];
        }
    }
}
    
#pragma mark - Handlers
    
- (IBAction)handleResetClicked:(id)sender {
    self.title = @"Select Start Square";
    if (self.startView) {
        [self.startView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.startView setBackgroundColor:[self colorAtRow:self.startView.boardRow
                                                     andCol:self.startView.boardColumn
                                                    reverse:NO]];
    }
    if (self.endView) {
        [self.endView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.endView setBackgroundColor:[self colorAtRow:self.endView.boardRow
                                                   andCol:self.endView.boardColumn
                                                  reverse:NO]];
    }
    
    [self clearMarkedViews];
    
    self.startView = nil;
    self.endView = nil;
    
    [self.calculateBarButtonItem setEnabled:NO];
    
    self.solutions = [NSMutableArray array];
    [self.resultsTableView reloadData];
}
    
- (IBAction)handleCalculateClicked:(id)sender {
    [self clearMarkedViews];
    
    KnightsShortestPath *ksp = [[KnightsShortestPath alloc] init];
    
    Square *startSquare = [[Square alloc] initWithRow:self.startView.boardRow andCol:self.startView.boardColumn];
    
    Square *endSquare = [[Square alloc] initWithRow:self.endView.boardRow andCol:self.endView.boardColumn];
    self.title = @"Calculating...";
    [ksp findShortestPathFrom:startSquare
                           to:endSquare
                        piece:[[Knight alloc] init]
            withMaxMovesCount:9
           withPathFoundBlock:^(NSArray *solution)
     {
         [self.solutions addObject:solution];
         [self.resultsTableView reloadData];
     } completionBlock:^{
         
         self.title = @"Finished...";
         if ([self.solutions count] == 0) {
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Finished Calculating" message:@"No Path found" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
             [alertController addAction:action];
             [self presentViewController:alertController animated:YES completion:nil];
         }
     }];
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
    
#pragma mark - Helper Functions
    
- (UILabel *) notationLabelWithFrame:(CGRect) frame andName:(NSString *) name {
    UILabel *notation = [[UILabel alloc] initWithFrame:frame];
    notation.textColor = [UIColor whiteColor];
    notation.textAlignment = NSTextAlignmentCenter;
    notation.font = [UIFont boldSystemFontOfSize:14.f];
    notation.text = name;
    //We mark boardRow and boardColumn with -1
    //so they are not returned when viewAtRow:col: is called
    notation.boardRow = -1;
    notation.boardColumn = -1;
    return notation;
}
    
- (UIColor*) colorAtRow:(NSInteger) row andCol:(NSInteger) col reverse:(BOOL) reversed {
    BOOL value = reversed ? row % 2 != col % 2 : row % 2 == col % 2;
    return value ? [UIColor whiteColor] : [UIColor blackColor];;
}
    
- (UIView*) viewAtRow:(NSInteger) row atCol:(NSInteger) col {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.boardRow == %ld AND self.boardColumn == %ld", row, col];
    return (UIView *) [[self.boardContainerView.subviews
                        filteredArrayUsingPredicate:predicate] objectAtIndex:0];
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
    
- (void) markViewsAtIndexPath:(NSIndexPath *) indexPath {
    [self clearMarkedViews];
    NSMutableArray *views = [NSMutableArray array];
    NSArray *moves = [self.solutions objectAtIndex:indexPath.row];
    for (NSInteger i=1; i<[moves count]-1; i++) {
        Square *square = (Square *) [moves objectAtIndex:i];
        UIView *view = [self viewAtRow:square.row atCol:square.col];
        [self addLabelWithText:[NSString stringWithFormat:@"%ld", i]
                        toView:view];
        [views addObject:view];
    }
    self.markedViews = [NSArray arrayWithArray:views];
    
}
    
- (void) clearMarkedViews {
    if (!self.markedViews)
    return;
    
    [self.markedViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [((UIView *)obj).subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }];
    self.markedViews = [NSMutableArray array];
}
    
- (void) animateMovesAtIndexPath: (NSIndexPath *) indexPath {
    NSArray *moves = [self.solutions objectAtIndex:indexPath.row];
    
    __block NSMutableArray* animationBlocks = [NSMutableArray array];
    animationBlock (^getNextAnimation)() = ^(){
        if ([animationBlocks count] > 0){
            animationBlock block = (animationBlock)[animationBlocks objectAtIndex:0];
            [animationBlocks removeObjectAtIndex:0];
            return block;
        } else {
            return ^(BOOL finished){
                animationBlocks = nil;
            };
        }
    };
    
    for (NSInteger i=0; i<[moves count]-1;i++) {
        Square *fromSquare = (Square *) [moves objectAtIndex:i];
        Square *toSquare = (Square *) [moves objectAtIndex:i+1];
        [animationBlocks addObject:^(BOOL finished) {
            NSLog(@"Animating from [%ld, %ld] to [%ld, %ld]",
                  fromSquare.row, fromSquare.col, toSquare.row, toSquare.col);
            
            UIView *fromView = [self viewAtRow:fromSquare.row atCol:fromSquare.col];
            NSLog(@"fromView x, y = [%f, %f]", fromView.frame.origin.x, fromView.frame.origin.y);
            
            UIView *toView = [self viewAtRow:toSquare.row atCol:toSquare.col];
            NSLog(@"toView x, y = [%f, %f]", toView.frame.origin.x, toView.frame.origin.y);
            
            __block UIImageView *knight = [[UIImageView alloc] initWithFrame:fromView.frame];
            [self.boardContainerView addSubview:knight];
            
            knight.backgroundColor = [UIColor brownColor];
            knight.image = [UIImage imageNamed:@"chessKnight"];
            
            [UIView animateWithDuration:1.0 animations:^{
                knight.frame = toView.frame;
            } completion:^(BOOL finished) {
                [knight removeFromSuperview];
                getNextAnimation()(finished);
            }];
            
        }];
    }
    
    getNextAnimation()(YES);
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
        NSString *reuseIdentifier = [ShortestPathTableViewCell reuseIdentifier];
        
        ShortestPathTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
    
- (void) configureCell:(ShortestPathTableViewCell *) cell
           atIndexPath:(NSIndexPath *) indexPath {
    cell.resultLabel.text = [self movesDescriptionAtIndexPath:indexPath];
    [cell.playButton addTarget:self
                        action:@selector(handlePlayButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
}
    
- (void)handlePlayButtonClicked:(UIButton *)sender {
    CGPoint center= sender.center;
    CGPoint rootViewPoint = [sender.superview convertPoint:center
                                                    toView:self.resultsTableView];
    NSIndexPath *indexPath = [self.resultsTableView indexPathForRowAtPoint:rootViewPoint];
    [self animateMovesAtIndexPath:indexPath];
}
    
- (NSString *) movesDescriptionAtIndexPath:(NSIndexPath *) indexPath {
    NSArray *moves = [self.solutions objectAtIndex:indexPath.row];
    __block NSString *description = @"";
    [moves enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Square *square = (Square*)obj;
        description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ > ", square]];
    }];
    description = [description substringToIndex:[description length] - 3];
    return description;
}
    
#pragma mark - TableViewDataDelegate
    
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self markViewsAtIndexPath:indexPath];
}
    
    @end
