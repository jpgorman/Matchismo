//
//  PlayingCardGame.m
//  
//
//  Created by Jean-Paul Gorman on 29/08/2016.
//
//

#import "PlayingCardGame.h"

@interface PlayingCardGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation PlayingCardGame

- (NSMutableArray *)cards
{
    if(_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    
    return __cards;
}

- (instancetype)initWithCardCount:(NSUInteger)
                   countUsingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
        }
    }
}

- (instancetype)init
{
    return nil;
}

@end
