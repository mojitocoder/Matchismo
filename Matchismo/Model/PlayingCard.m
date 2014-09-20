//
//  PlayingCard.m
//  Matchismo
//
//  Created by Quynh Nguyen on 19/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import "PlayingCard.h"

NSString * const PlayingCardSuitHeart = @"♥︎";
NSString * const PlayingCardSuitDiamond=@"♦︎";
NSString * const PlayingCardSuitSpade=@"♣︎";
NSString * const PlayingCardSuitClub=@"♠︎";

@implementation PlayingCard

+ (NSArray *) validSuits
{
    static NSArray *suits = nil;
    if (!suits)
        suits = @[PlayingCardSuitHeart,
                  PlayingCardSuitDiamond,
                  PlayingCardSuitSpade,
                  PlayingCardSuitClub];
    return suits;
}

+ (NSArray *) validRanks
{
    static NSArray *rank = nil;
    if(!rank)
        rank = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return rank;
}

+ (NSUInteger) maxRank
{
    NSArray *ranks = [PlayingCard validRanks];
    return [ranks count] - 1;
}


@synthesize suit = _suit;

- (NSString *) suit
{
    return (_suit)? _suit : @"Ø";
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}


- (NSString *) contents
{
    NSArray *rank = [PlayingCard validRanks];
    return [rank[self.rank] stringByAppendingString:self.suit];
}


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    //looks like this is a lambda expression in Objective C
    BOOL (^isSameSuit)(id, NSUInteger, BOOL*);
    BOOL (^isSameRank)(id, NSUInteger, BOOL*);
    
    if ([otherCards count] > 0)
    {
        isSameSuit = ^(id obj, NSUInteger idx, BOOL *stop)
        {
            return (BOOL) ([obj isKindOfClass:[PlayingCard class]]? [self.suit isEqualToString:[obj suit]]: NO);
        };
        
        isSameRank = ^(id obj, NSUInteger idx, BOOL *stop)
        {
            return (BOOL)([obj isKindOfClass:[PlayingCard class]]? self.rank == [obj rank]: NO);
        };
        
        BOOL suitsMatch = ([otherCards count] == [[otherCards indexesOfObjectsPassingTest:isSameSuit] count]);
        BOOL ranksMatch = ([otherCards count] == [[otherCards indexesOfObjectsPassingTest:isSameRank] count]);
        
        if (suitsMatch) {
            score = 1;
        } else if (ranksMatch){
            score = 4;
        }
    }
    return score;
}

@end
