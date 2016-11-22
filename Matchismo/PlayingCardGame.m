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
@property (nonatomic, readwrite) NSMutableAttributedString *currentMatchState;
@property (nonatomic, readwrite) NSMutableArray *currentMatchStateArray;
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

- (NSMutableAttributedString *)currentMatchState
{
    if(!_currentMatchState) _currentMatchState = [[NSMutableAttributedString alloc] initWithString:@""];
    return _currentMatchState;
}

- (NSMutableArray *)currentMatchStateArray
{
    if (!_currentMatchStateArray) _currentMatchStateArray = [[NSMutableArray alloc] init];
    return _currentMatchStateArray;
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

- (void)updateScore:(int)score
{
    self.score += score;
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%d", @"You scored: ", score]];
    [self updateCurrentMatchState:contents];
}

- (void)getScores
{
    NSUInteger count = [self.chosenCards count] - 1;
    
    if(count == self.matchLimit - 1) {

        Card *firstCard = [self.chosenCards objectAtIndex:0];
        
        int matchScore = [firstCard match:self.chosenCards];
        // match if score isn't nil
        if (matchScore) {
            [self updateScore:matchScore * MATCH_BONUS];
            self.score += matchScore * MATCH_BONUS;
        } else {
            [self updateScore:-1*MISMATCH_PENALTY];
            self.score -= MISMATCH_PENALTY;
        }
    }
}

-(void)updateCurrentMatchState:(NSAttributedString *)stringToAdd
{
    [self.currentMatchStateArray addObject:stringToAdd];
    [self.currentMatchState appendAttributedString:stringToAdd];
}

- (void)matchChosenCards
{
    
    NSUInteger count = [self.chosenCards count] - 1;
    
    if(count == self.matchLimit -1) {
        
        bool isMatched = YES;
        Card *firstCard = [self.chosenCards objectAtIndex:0];
        
        int matchScore = [firstCard match:self.chosenCards];
        
        // if no match then break
        if (!matchScore) {
            isMatched = NO;
        }
        
        
        if(!isMatched) {
            
            NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"Cards Didn't Match 😭"]];
            
            [self updateCurrentMatchState:contents];
            
            // mark all cards unmatched
            for(Card *card in self.chosenCards) {
                card.matched = NO;
            }
            
        } else {
            
            NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"Cards Matched 😍"]];
            
            [self updateCurrentMatchState:contents];
            
            
            // mark all cards matched
            // remove from chosen cards
            for(Card *card in self.chosenCards) {
                card.matched = YES;
            }
            [self.chosenCards removeAllObjects];
        }
    }
}

- (void)checkForMatches:(void (^)(void))callback {
    if([self.chosenCards count] == self.matchLimit) {
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            for(Card *card in self.chosenCards) {
                card.chosen = NO;
            }
            [self.chosenCards removeAllObjects];
            callback(); // invoke block
        });
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
                
                [self updateScore:-1*COST_TO_CHOOSE];
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
