//
//  SetViewController.m
//  
//
//  Created by Jean-Paul Gorman on 26/09/2016.
//
//

#import "SetViewController.h"
#import "SetCard.h"
#import "SetDeck.h"
#import <QuartzCore/QuartzCore.h>

@interface SetViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation SetViewController
@dynamic cardButtons;

- (Deck *) createDeck
{
    return [[SetDeck alloc] init];
}

#define SHADING_ALPHA 0.3

- (UIColor *)getColor:(NSString *)clr withShading:(NSUInteger)shading
{
    UIColor *color = [UIColor whiteColor];
    if([clr isEqualToString:@"Red"]) color = [UIColor redColor];
    if([clr isEqualToString:@"Green"]) color = [UIColor greenColor];
    if([clr isEqualToString:@"Purple"]) color = [UIColor purpleColor];
    
    if(shading == 1) color = [color colorWithAlphaComponent:0];
    if(shading == 2) color = [color colorWithAlphaComponent:SHADING_ALPHA];
    if(shading == 3) color = [color colorWithAlphaComponent:1];
    return color;
}

#define STROKE_WIDTH @-9

- (NSAttributedString *)getAttributedStringForCard:(SetCard *)card
{
    // wrtie number of symbols
    NSString *symbol = [[NSString alloc] init];
    for (int i = 0; i < card.number; i++) {
        symbol = [NSString stringWithFormat:@"%@%@", symbol, card.symbol];
    }
    
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:symbol];
    
    
    NSDictionary *attributes = @{
                                 NSStrokeColorAttributeName: [self getColor:card.color withShading:2],
                                 NSStrokeWidthAttributeName: STROKE_WIDTH,
                                 NSForegroundColorAttributeName: [self getColor:card.color withShading:card.shading]
                                 };
    
    NSRange range = NSMakeRange(0, attString.length);
    [attString setAttributes:attributes range:range];
    
    return attString;
}

#define CARD_LIMIT 3

- (IBAction)handleButtonEvent:(UIButton *)sender {
    
    NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex withLimit:CARD_LIMIT];
    [self updateUI];
}

- (void)updateUI
{
    [super updateUI];
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardIndex];
        
        NSAttributedString *attString = [self getAttributedStringForCard:card];
        [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        
        
        // card border radius
        [[cardButton layer] setBorderWidth:1.0f];
        [[cardButton layer] setCornerRadius:5.0f];
        [[cardButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        
        if(card.isChosen) {
            [cardButton setBackgroundColor:[UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:0.3]];
        } else {
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        }
        
        [cardButton setAttributedTitle:attString forState:UIControlStateNormal];
        
    }
    
}

@end
