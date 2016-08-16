//
//  ViewController.m
//  Matchismo
//
//  Created by Jean-Paul Gorman on 16/08/2016.
//  Copyright (c) 2016 Jean-Paul Gorman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (nonatomic) int flipCount;
@end

@implementation ViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flip Count: %d"
                                , self.flipCount];
    NSLog(@"%d", self.flipCount);
}

- (IBAction)handleButtonEvent:(UIButton *)sender {
    
    if([sender.currentTitle length]) {
        UIImage *cardImage = [UIImage imageNamed:@"back"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        UIImage *cardImage = [UIImage imageNamed:@"front"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];
    }
    self.flipCount++;

}


@end
