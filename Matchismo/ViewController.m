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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *deck;
@property (strong, nonatomic) NSMutableArray *shownCards;
@property (nonatomic) BOOL active;
@property (nonatomic) Card *drawCard;
@property (nonatomic) NSUInteger maxCards;
@end


@implementation ViewController

- (Deck *)deck {
    if(!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (NSUInteger)maxCards {
    
    if(!_maxCards) {
        _maxCards = [[PlayingCard validSuits] count] * [PlayingCard  maxRank];
    }
    return _maxCards;
}

- (NSMutableArray *)shownCards {
    if(!_shownCards) _shownCards = [[NSMutableArray alloc] init];
    return _shownCards;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flip Count: %d"
                                , self.flipCount];
}

- (Card *)drawCard {
    Card *currentCard = [self.deck drawRandomCard];
    
    if([currentCard match: self.shownCards]){
        return [self drawCard];
    }
    
    if([self.shownCards count] == self.maxCards){
        [self.shownCards removeAllObjects];
    }
    
    [self.shownCards addObject:currentCard];
    return currentCard;
}

- (IBAction)handleButtonEvent:(UIButton *)sender {
    self.active = !self.active;
    if(!self.active) {
        UIImage *cardImage = [UIImage imageNamed:@"back"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        UIImage *cardImage = [UIImage imageNamed:@"front"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:[self drawCard].contents forState:UIControlStateNormal];
    }
    
    self.flipCount++;

}


@end
