//
//  Deck.h
//  Matchismo
//
//  Created by Quynh Nguyen on 19/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard: (Card *)card atTop:(BOOL)yesNo;
- (Card *) drawRandomCard;

@end
