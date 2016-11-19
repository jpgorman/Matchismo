//
//  PlayingCardGame.h
//  
//
//  Created by Jean-Paul Gorman on 29/08/2016.
//
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface PlayingCardGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index
            withLimit:(int)limit;

- (void)updateCurrentMatchState:(NSAttributedString *)stringToAdd;
- (void)checkForMatches:(void(^)(void))callback;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSMutableArray *chosenCards;
@property (nonatomic, readonly) NSMutableAttributedString *currentMatchState;
@property (nonatomic, readonly) NSMutableArray *currentMatchStateArray;

@end
