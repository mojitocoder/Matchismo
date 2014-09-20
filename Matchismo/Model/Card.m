//
//  Card.m
//  Matchismo
//
//  Created by Quynh Nguyen on 19/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import "Card.h"

@implementation Card

//This is how you explicitly synthesize a property
/*
@synthesize contents = _contents;

- (NSString *) contents
{
    return _contents;
}

- (void) setContents:(NSString *)contents
{
    _contents = contents;
}
*/


- (int)match:(NSArray *)otherCards
{
    int score = 0;
  
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
