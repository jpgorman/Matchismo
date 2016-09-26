//
//  SetViewController.m
//  
//
//  Created by Jean-Paul Gorman on 26/09/2016.
//
//

#import "SetViewController.h"

@interface SetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *SetViewTitle;

@end

@implementation SetViewController

- (void)setThingToPass:(NSString *)thingToPass
{
    _thingToPass = thingToPass;
    // update ui when infocus
    if (self.view.window) [self updateUI];
}

- (void)viewDidLoad
{
    self.thingToPass = @"New thing";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    // self.SetViewTitle.text = self.thingToPass;
}

@end
