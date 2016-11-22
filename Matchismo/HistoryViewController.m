//
//  HistoryController.m
//  Matchismo
//
//  Created by Jean-Paul Gorman on 02/11/2016.
//  Copyright © 2016 Jean-Paul Gorman. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

static const int VIEW_HEIGHT = 50;
static const int VIEW_SPACING = 1;

@implementation HistoryViewController

#pragma mark - initialisation
- (void)setHistory:(NSAttributedString *)history
{
    _history = history;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


#pragma mark - update UI
- (void) updateUI {
    
    NSLog(@"%@", self.historyArray);
    
    
    //Stack View
    UIStackView *stackView = [[UIStackView alloc] init];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = VIEW_SPACING;
    
    for (NSAttributedString *history in self.historyArray) {
        
        //View 1
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = [UIColor whiteColor];
        [view1.heightAnchor constraintEqualToConstant:VIEW_HEIGHT].active = true;
        [view1.widthAnchor constraintEqualToConstant:self.scrollView.bounds.size.width].active = true;
        
        // Add a bottomBorder.
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0, VIEW_HEIGHT, self.scrollView.bounds.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                         alpha:1.0f].CGColor;
        
        [[view1 layer] addSublayer:bottomBorder];
        
        UILabel* lblText = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.scrollView.bounds.size.width, VIEW_HEIGHT)];
        lblText.attributedText = history;
        [view1 addSubview:lblText];
        
        
        [stackView addArrangedSubview:view1];
    }
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [self.scrollView addSubview:stackView];
    
    CGSize newContentSize=self.scrollView.contentSize;
    newContentSize.height+=(VIEW_SPACING + VIEW_HEIGHT)*[self.historyArray count] - VIEW_SPACING;
    [self.scrollView setContentSize:newContentSize];
    
    
    //Layout for Stack View
    [stackView.centerXAnchor constraintEqualToAnchor:self.scrollView.centerXAnchor].active = true;
    [stackView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = true;
}

@end
