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

@property (nonatomic, readwrite) NSUInteger matchingCards;

@property (nonatomic, strong) NSMutableArray * chosenCards;

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


- (NSMutableArray *) chosenCards
{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (instancetype) initWithCardCount: (NSUInteger)count
                         usingDeck: (Deck *)deck
                              with: (NSUInteger)matchingCards
{
    self = [super init];
    
    if (self)
    {
        if (matchingCards < 2) return nil;
        
        //store the number of matching cards (game mode)
        self.matchingCards = matchingCards;
        
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject: card];
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

- (void) chooseCardAtIndex: (NSUInteger)index
{
    Card *card = [self cardAtIndex: index];
    
    if (!card.isMatched)
    {
        if (card.isChosen)
        {
            // Flip the card only
            // Here is the case where the user flips the cards
            //  to see what they are and then flips them back - to avoid penalty
            card.chosen = NO;
        }
        else
        {
            //Get the list of other chosen cards at this point
            [self.chosenCards removeAllObjects];
            for (Card *otherCard in self.cards)
            {
                if (!otherCard.isMatched && otherCard.isChosen)
                    [self.chosenCards addObject: otherCard];
            }
            
            //Only evaluate any matching when the total number of
            // chosen cards reaches the pre-defined number
            NSUInteger chosenCardsCount = [self.chosenCards count];
            if (chosenCardsCount == self.matchingCards - 1)
            {
                int matchingScore = [card match: self.chosenCards];
                if (matchingScore)
                {
                    self.score += matchingScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in self.chosenCards)
                    {
                        otherCard.matched = YES;
                    }
                }
                else
                {
                    //no match => flip all cards over + penalty,
                    //  but leave the current card at the current stage
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in self.chosenCards)
                    {
                        otherCard.chosen = NO;
                    }
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

- (BOOL) gameStarted
{
    for (Card *card in self.cards) {
        if (card.chosen || card.matched) return YES;
    }
    return NO;
}

@end
