//
//  Deck.m
//  Matchismo
//
//  Created by Quynh Nguyen on 19/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *) cards
{
    if(!_cards) _cards =[[NSMutableArray alloc] init];
    return _cards;
}


- (void) addCard: (Card *)card atTop:(BOOL)yesNo
{
    if (yesNo) {
        [self.cards insertObject:card atIndex:0];
    }
    else
    {
        [self.cards addObject:card];
    }
}

- (Card *) drawRandomCard
{
    Card *randomCard;
    
    if ([self.cards count])
    {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
