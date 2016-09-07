//
//  ViewController.m
//  Matchismo
//
//  Created by Jean-Paul Gorman on 16/08/2016.
//  Copyright (c) 2016 Jean-Paul Gorman. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardGame.h"

@interface ViewController ()
@property (nonatomic) BOOL isMatchingMax;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchingLimitLabel;
@property (weak, nonatomic) IBOutlet UILabel *chosenLabel;
@property (nonatomic) Deck *deck;
@property (nonatomic, strong) PlayingCardGame *game;
@property (weak, nonatomic) IBOutlet UISwitch *toggleNumber;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
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
    return [[PlayingCardDeck alloc] init];
}

- (int)getMatchLimit
{
    int limit = self.isMatchingMax ? MAX_MATCH_LIMIT : MIN_MATCH_LIMIT;
    return limit;
}

- (IBAction)handleButtonEvent:(UIButton *)sender {
    
    NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex withLimit:[self getMatchLimit]];
    [self updateUI];
}

- (IBAction)handleToggleEvent:(UISwitch *)sender
{
    self.isMatchingMax = !self.isMatchingMax;
    self.matchingLimitLabel.text = [NSString stringWithFormat:@"Matching: %d", [self getMatchLimit]];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    self.chosenLabel.text = [NSString stringWithFormat:@"Currently Chosen: %@", self.game.currentMatchState];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"front" : @"back"];
}

@end
