//
//  SetCard.h
//  Matchismo
//
//  Created by Jean-Paul Gorman on 08/10/2016.
//  Copyright © 2016 Jean-Paul Gorman. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSString *symbol;
@property (nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;

+ (NSArray *)symbols;
+ (NSArray *)numbers;
+ (NSArray *)colors;
+ (NSArray *)shadings;

@end
