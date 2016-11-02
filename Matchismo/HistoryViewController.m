//
//  HistoryController.m
//  Matchismo
//
//  Created by Jean-Paul Gorman on 02/11/2016.
//  Copyright © 2016 Jean-Paul Gorman. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;

@end

@implementation HistoryViewController

- (void)setHistory:(NSString *)history
{
    _history = history;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)preferredFontsChanged:(NSNotification *)notification
{
    [self usePreferredFonts];
}

- (void)usePreferredFonts
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (void)updateUI
{
    self.body.text = [self.body.text stringByAppendingString:self.history];
}

@end
