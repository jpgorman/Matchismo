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

@implementation HistoryViewController

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


- (void)drawText:(CGFloat)xPosition yPosition:(CGFloat)yPosition canvasWidth:(CGFloat)canvasWidth canvasHeight:(CGFloat)canvasHeight
{
    //Draw Text
    CGRect textRect = CGRectMake(xPosition, yPosition, canvasWidth, canvasHeight);
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 12], NSForegroundColorAttributeName: UIColor.redColor, NSParagraphStyleAttributeName: textStyle};
    
    [@"Hello, World!" drawInRect: textRect withAttributes: textFontAttributes];
}

- (void) updateUI {
    
    NSLog(@"%@", self.historyArray);
    
    
    //Stack View
    UIStackView *stackView = [[UIStackView alloc] init];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 30;
    
    for (NSAttributedString *history in self.historyArray) {
        
        //View 1
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = [UIColor blueColor];
        [view1.heightAnchor constraintEqualToConstant:100].active = true;
        [view1.widthAnchor constraintEqualToConstant:self.scrollView.bounds.size.width].active = true;
        
        UILabel* lblText = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.scrollView.bounds.size.width, 100)];
        lblText.attributedText = history;
        lblText.textColor = [UIColor whiteColor];
        [view1 addSubview:lblText];
        
        
        [stackView addArrangedSubview:view1];
    }
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [self.scrollView addSubview:stackView];
    
    CGSize newContentSize=self.scrollView.contentSize;
    newContentSize.height+=130*[self.historyArray count] - 30;
    [self.scrollView setContentSize:newContentSize];
    
    
    //Layout for Stack View
    [stackView.centerXAnchor constraintEqualToAnchor:self.scrollView.centerXAnchor].active = true;
    [stackView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = true;
}

@end
