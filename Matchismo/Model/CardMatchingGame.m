//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Quynh Nguyen on 21/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardMatchingGame()

//This is the weird way in Objective C to overwrite
//  the signature of a property defined in the interface.
//  score will be read-only externally, but read-write internally
@property (nonatomic, readwrite) NSInteger score;

@property (nonatomic, strong) NSMutableArray *cards;
@end


@implementation CardMatchingGame

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self)
    {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject:card];
            }
            else //return a nil (for CardMatchingGame's initialiser if params are invalid)
            {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex: index];
    
    if (!card.isMatched)
    {
        if (card.isChosen) //flip the card only
        {
            card.chosen = NO;
        }
        else
        {
            for (Card *otherCard in self.cards)
            {
                //match against all other cards which have been chosen,
                //  but not yet matched to other card(s)
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore)
                    {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else
                    {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    
                    break; //because the game only supports 2 card matching at the moment
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count])? self.cards[index]: nil;
}

@end
