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
@property (nonatomic) Deck *deck;
@property (nonatomic, strong) PlayingCardGame *game;
@property (weak, nonatomic) IBOutlet UISwitch *toggleNumber;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end


static const BOOL MATCHING_MAX = false;

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

- (IBAction)handleButtonEvent:(UIButton *)sender {
    
    int limit = self.isMatchingMax ? 3 : 2;
    NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex withLimit:limit];
    [self updateUI];
}

- (IBAction)handleToggleEvent:(UISwitch *)sender
{
    self.isMatchingMax = !self.isMatchingMax;
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
