//
//  ViewController.h
//  Matchismo
//
//  Created by Jean-Paul Gorman on 16/08/2016.
//  Copyright (c) 2016 Jean-Paul Gorman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "PlayingCardGame.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) PlayingCardGame *game;
@property (nonatomic) NSUInteger cardCount;
@property (nonatomic) NSUInteger cardsToMatch;

- (Deck *)createDeck; // abstract
- (void)updateUI; // abstract

@end

