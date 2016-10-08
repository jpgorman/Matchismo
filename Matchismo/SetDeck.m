//
//  SetDeck.m
//  Matchismo
//
//  Created by Jean-Paul Gorman on 08/10/2016.
//  Copyright © 2016 Jean-Paul Gorman. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (instancetype)init
{
    self = [super init];
    
    if(self) {
        for (NSString *symbol in [SetCard symbols]) {
            for (NSString *color in [SetCard colors]) {
                for (NSUInteger number = 1; number <= [SetCard numbers].count; number++) {
                    for (NSUInteger shading = 1; shading <= [SetCard shadings].count; shading++) {
           
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
