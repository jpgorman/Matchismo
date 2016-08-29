//
//  PlayingCardGame.h
//  
//
//  Created by Jean-Paul Gorman on 29/08/2016.
//
//

#import <Foundation/Foundation.h>
#import "Deck.h

@interface PlayingCardGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)
                   countUsingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
