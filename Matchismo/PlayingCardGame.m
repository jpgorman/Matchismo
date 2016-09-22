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
@property (nonatomic, readwrite) NSMutableString *currentMatchState;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic) int matchLimit;
@end

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int DEFAULT_MATCH_LIMIT = 2;


@implementation PlayingCardGame
@synthesize matchLimit = _matchLimit; // because custom setter and getter

- (NSMutableString *)currentMatchState
{
    if(!_currentMatchState) _currentMatchState = [NSMutableString stringWithString:@""];
    return _currentMatchState;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (int)matchLimit
{
    return _matchLimit ? _matchLimit : DEFAULT_MATCH_LIMIT;
}

- (void)setMatchLimit:(int)limit
{
    _matchLimit = limit;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void)getScores
{
    
    NSUInteger count = [self.chosenCards count] - 1;
    
    if(count == self.matchLimit - 1) {

        Card *firstCard = [self.chosenCards objectAtIndex:0];
        
        for (NSUInteger i = 1; i <= count; i++) {
            Card *cardToCompareWith = [self.chosenCards objectAtIndex:i];
            int matchScore = [cardToCompareWith match:@[firstCard]];
            // match if score isn't nil
            if (matchScore) {
                [self updateCurrentMatchState:[NSString stringWithFormat:@"%d", matchScore * MATCH_BONUS]];
                self.score += matchScore * MATCH_BONUS;
            } else {
                [self updateCurrentMatchState:[NSString stringWithFormat:@"%d", MISMATCH_PENALTY]];
                self.score -= MISMATCH_PENALTY;
            }
        }
    }
}

-(void)updateCurrentMatchState:(NSString *)stringToAdd
{
    [self.currentMatchState appendString:stringToAdd];
    [self.currentMatchState appendString:@" "];
}

-(void)resetCurrentMatchState
{
    [self.currentMatchState setString:@""];
}

- (void)matchChosenCards
{
    
    NSUInteger count = [self.chosenCards count] - 1;
    
    if(count == self.matchLimit -1) {
        
        bool isMatched = YES;
        Card *firstCard = [self.chosenCards objectAtIndex:0];
        
        for (NSUInteger i = 1; i <= count; i++) {
            
            Card *cardToCompareWith = [self.chosenCards objectAtIndex:i];
            int matchScore = [cardToCompareWith match:@[firstCard]];
            // if no match then break
            if (!matchScore) {
                isMatched = NO;
                break;
            }

        }
        
        
        if(!isMatched) {
            
            // mark all cards unmatched
            for(Card *card in self.chosenCards) {
                card.matched = NO;
            }
            
        } else {
            // mark all cards matched
            // remove from chosen cards
            for(Card *card in self.chosenCards) {
                card.matched = YES;
            }
            [self.chosenCards removeAllObjects];
        }
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index
                 withLimit:(int)limit
{
    Card *card = [self cardAtIndex:index];
    
    self.matchLimit = limit;
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            // remove from list of chosen cards
            [self.chosenCards removeObject:card];
        } else {
            // add to list of chosen cards
            
            if([self.chosenCards count] < self.matchLimit) {
                
                if([self.chosenCards count] == 0) {
                    // reset match state
                    [self resetCurrentMatchState];
                }
                
                [self updateCurrentMatchState:card.contents];
                
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            
                [self.chosenCards addObject:card];
                [self getScores];
                [self matchChosenCards];
            }
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init
{
    return nil;
}

@end
