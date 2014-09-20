//
//  Card.h
//  Matchismo
//
//  Created by Quynh Nguyen on 19/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
