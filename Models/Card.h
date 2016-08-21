//
//  Card.h
//  
//
//  Created by Jean-Paul Gorman on 18/08/2016.
//
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL chosen;

- (int)match:(NSArray *)otherCards;

@end
