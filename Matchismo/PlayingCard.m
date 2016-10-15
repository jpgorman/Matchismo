//
//  PlayingCard.m
//  
//
//  Created by Jean-Paul Gorman on 18/08/2016.
//
//

#import "PlayingCard.h"

@implementation PlayingCard

#define SUIT_MATCH 1
#define RANK_MATCH 4

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    
    NSMutableArray *cards = [NSMutableArray arrayWithArray:otherCards];
    [cards addObject:self];
    
    NSMutableSet *ranks = [[NSMutableSet alloc] init];
    NSMutableSet *suits = [[NSMutableSet alloc] init];
    
    for (PlayingCard *otherCard in cards) {
        [ranks addObject:@(otherCard.rank)];
        [suits addObject:otherCard.suit];
    }
    
    
    if (suits.count == 1) {
        score = (cards.count == 2) ? SUIT_MATCH : SUIT_MATCH * (int)cards.count;
    } else if (ranks.count == 1) {
        score = (cards.count == 2) ? RANK_MATCH : RANK_MATCH * (int)cards.count;
    }

    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because custom setter and getter

+ (NSArray *)validSuits
{
    return @[@"♥︎", @"♣︎", @"♠︎", @"♦︎"];
}

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

@end
