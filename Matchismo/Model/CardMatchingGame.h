//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Quynh Nguyen on 21/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

// There is no way in Objective C to designate the
//  default initialiser.
//  Developers have to manually make sure the code call the correct one
- (instancetype) initWithCardCount: (NSUInteger)count
                         usingDeck: (Deck *)deck
                              with: (NSUInteger)matchingCards;

- (void) chooseCardAtIndex: (NSUInteger)index;
- (Card*) cardAtIndex: (NSUInteger)index;


@property (nonatomic, readonly) NSInteger score;

@property (nonatomic, readonly) NSUInteger matchingCards;

@property (nonatomic, readonly) BOOL gameStarted;

@end
