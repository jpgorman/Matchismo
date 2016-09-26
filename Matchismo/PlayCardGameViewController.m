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

@end

@implementation PlayCardGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Set Game"]) {
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

@end
