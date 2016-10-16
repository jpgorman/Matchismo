//
//  PlayCardGameViewController.m
//  
//
//  Created by Jean-Paul Gorman on 12/09/2016.
//
//

#import "PlayCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "SetViewController.h"

@interface PlayCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation PlayCardGameViewController
@dynamic cardButtons;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Set"]) {
        if([segue.destinationViewController isKindOfClass:[SetViewController class]]) {
            SetViewController *svc = (SetViewController *)segue.destinationViewController;
            svc.thingToPass = @"thing to pass";
        }
    }
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}



#define CARD_LIMIT 2

- (IBAction)handleButtonEvent:(UIButton *)sender {
    
    NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex withLimit:CARD_LIMIT];
    [self updateUI];
}


- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (void)updateUI
{
    [super updateUI];
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
    }
}

@end
