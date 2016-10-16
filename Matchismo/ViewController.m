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

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"front" : @"back"];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        cardButton.alpha = card.isMatched ? 0.3 : 1.0;
        
        
        // card border radius
        [[cardButton layer] setBorderWidth:1.0f];
        [[cardButton layer] setCornerRadius:5.0f];
        [[cardButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        
        if(card.isChosen) {
            [cardButton setBackgroundColor:[UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:0.9]];
        } else {
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    self.chosenLabel.text = [NSString stringWithFormat:@"Currently Chosen: %@", self.game.currentMatchState];
}

- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
    self.chosenLabel.text = @"";
    self.scoreLabel.text = @"";
    [self updateUI];
}

@end
