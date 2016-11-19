//
//  PlayCardGameViewController.m
//  
//
//  Created by Jean-Paul Gorman on 12/09/2016.
//
//

#import "PlayCardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"

@interface PlayCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *cardButtons;
@end;


@implementation PlayCardGameViewController
@dynamic cardButtons;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayingCardHistory"]) {
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.history = self.game.currentMatchState;
            hvc.historyArray = self.game.currentMatchStateArray;
        }
    }
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}


#define CARD_LIMIT 2

- (void)tap:(UITapGestureRecognizer *)sender
{
    
    if ((sender.state == UIGestureRecognizerStateEnded)) {
        
        if([sender.view isKindOfClass:[PlayingCardView class]])
        {
            NSUInteger index = [self.cardButtons indexOfObject:sender.view];
            [self.game chooseCardAtIndex:index withLimit:CARD_LIMIT];
            PlayingCard *playingcard = (PlayingCard *)[self.game cardAtIndex:index];
            if(playingcard.isChosen) {
                NSAttributedString *contents = [[NSAttributedString alloc] initWithString:playingcard.contents];
                [self.game updateCurrentMatchState:contents];
            }
            [self updateUI];
            [self.game checkForMatches:^{
                [self updateUI];
            }];
        }
    }
}

- (void)updateUI
{
    [super updateUI];
    for (PlayingCardView *playingCardView in self.cardButtons) {
        
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        
        NSUInteger cardIndex = [self.cardButtons indexOfObject:playingCardView];
        PlayingCard *playingcard = (PlayingCard *)[self.game cardAtIndex:cardIndex];
        playingCardView.suit = playingcard.suit;
        playingCardView.rank = playingcard.rank;
        playingCardView.faceUp = playingcard.isChosen;
        [playingCardView addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
