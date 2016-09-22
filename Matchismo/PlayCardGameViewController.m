//
//  PlayCardGameViewController.m
//  
//
//  Created by Jean-Paul Gorman on 12/09/2016.
//
//

#import "PlayCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayCardGameViewController ()

@end

@implementation PlayCardGameViewController

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
