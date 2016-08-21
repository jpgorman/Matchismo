//
//  Deck.h
//  
//
//  Created by Jean-Paul Gorman on 18/08/2016.
//
//

#import <Foundation/Foundation.h>

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
