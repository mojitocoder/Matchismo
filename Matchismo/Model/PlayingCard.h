//
//  PlayingCard.h
//  Matchismo
//
//  Created by Quynh Nguyen on 19/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import "Card.h"

extern NSString * const PlayingCardSuitHeart;
extern NSString * const PlayingCardSuitDiamond;
extern NSString * const PlayingCardSuitSpade;
extern NSString * const PlayingCardSuitClub;

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, readonly) BOOL inRed;

+ (NSArray *) validSuits;
+ (NSArray *) validRanks;
+ (NSUInteger) maxRank;

@end
