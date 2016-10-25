//
//  ViewController.m
//  Matchismo
//
//  Created by Jean-Paul Gorman on 16/08/2016.
//  Copyright (c) 2016 Jean-Paul Gorman. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardGame.h"

@interface ViewController ()
@property (nonatomic) BOOL isMatchingMax;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *chosenLabel;
@property (nonatomic) Deck *deck;
@end


static const BOOL MATCHING_MAX = false;
static const int MIN_MATCH_LIMIT = 2;
static const int MAX_MATCH_LIMIT = 3;

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (BOOL)isMatchingMax
{
    if(!_isMatchingMax) _isMatchingMax = MATCHING_MAX;
    return _isMatchingMax;
}

- (PlayingCardGame *)game
{
    if(!_game) _game = [[PlayingCardGame alloc] initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)deck {
    if(!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return nil;
}

- (int)getMatchLimit
{
    int limit = self.isMatchingMax ? MAX_MATCH_LIMIT : MIN_MATCH_LIMIT;
    return limit;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        cardButton.enabled = !card.isMatched;
        cardButton.alpha = card.isMatched ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    self.chosenLabel.text = [NSString stringWithFormat:@"Currently Chosen: %@", self.game.currentMatchState];
}

- (IBAction)deal:(UIButton *)sender {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Confirmation"
                                 message:@"Do you want to reset game?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self startNewGame];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:nil];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)startNewGame
{
    self.game = nil;
    self.chosenLabel.text = @"";
    self.scoreLabel.text = @"";
    [self updateUI];
}

@end
