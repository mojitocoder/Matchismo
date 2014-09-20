//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Quynh Nguyen on 18/09/2014.
//  Copyright (c) 2014 ___QuynhNguyen___. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int count;
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController

- (Deck *) deck
{
    if (!_deck)
        _deck = [self createDeck];
    
    return _deck;
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void) setCount:(int)count {
    _count = count;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.count];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    self.count ++;
    
    NSLog(@"Touch %d ...", self.count);
    
    if ([sender.currentTitle length]) {
        
        //clear the card title
        [sender setTitle:@"" forState:UIControlStateNormal];
        
        //and set the background image to the back image
        UIImage *image = [UIImage imageNamed:@"cardback"];
        [sender setBackgroundImage:image
                          forState:UIControlStateNormal];
    
    } else {
    
        Card *randomCard = [self.deck drawRandomCard];
        
        [sender setTitle:randomCard.contents forState:UIControlStateNormal];
    
        UIImage *image = [UIImage imageNamed:@"cardfront"];
        [sender setBackgroundImage:image
                          forState:UIControlStateNormal];
    }
}


@end


//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view, typically from a nib.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}