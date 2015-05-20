//
//  Card.m
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "Card.h"
#import "CardModel.h"
#import "RarityModel.h"
#import "CoreData+MagicalRecord.h"
#import "UIView+Positioning.h"
#import "UNIRest.h"

#define closedWidth 66
#define openedWidth 70
#define closedHeight 93

@interface Card()

@property (strong, nonatomic) UIImage *frontImage;

@property (nonatomic) NSString *rarity;

@property (nonatomic) BOOL isGolden;

@end

@implementation Card

-(id)initWithBack:(NSString *)back {
    
    self = [super init];
    if (self) {
        self = [Card buttonWithType:UIButtonTypeCustom];
        [self setImage:[UIImage imageNamed:back] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:back] forState:UIControlStateSelected];
        self.backgroundColor = [UIColor clearColor];
        self.size = CGSizeMake(closedWidth, closedHeight);
        [self addTarget:self action:@selector(turnCard) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}


- (void)turnCard {
    
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.width = 0;
        self.x += closedWidth / 2;
    } completion:^(BOOL finished) {
        [self setImage:_frontImage forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            self.width = openedWidth;
            self.x -= openedWidth / 2;
        }];
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cardNotification" object:self];
}

- (void)rollCard {
    
    RarityModel *rarity = [RarityModel MR_findFirstByAttribute:@"rarityType" withValue:self.rarity];
    NSArray *cardsArray = [rarity.cards allObjects];
    CardModel *card = [cardsArray objectAtIndex:arc4random_uniform((uint)cardsArray.count)];
    
    // Image request
    
    [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:(self.isGolden ? card.imageGolden : card.image)];
    }] asBinaryAsync:^(UNIHTTPBinaryResponse *binaryResponse, NSError *error) {
        self.frontImage = [UIImage imageWithData:binaryResponse.body];
        NSLog(@"=== Card image loaded ===");
    }];
}


- (BOOL)rollRarity {
    
    float random = arc4random_uniform(101000);
    random /= 1000;
    
    NSLog(@"random = %f", random);
    self.isGolden = NO;
    
    // common
    if (random <= 69.981) {
        NSLog(@"common");
        self.rarity = @"Common";
        return NO;
    }
    // rare
    if (random <= 91.381 & random > 69.981) {
        NSLog(@"rare");
        self.rarity = @"Rare";
        return YES;
    }
    // epic
    if (random <= 95.661 & random > 91.381) {
        NSLog(@"epic");
        self.rarity = @"Epic";
        return YES;
    }
    //legend
    if (random <= 96.741 & random > 95.661) {
        NSLog(@"legen");
        self.rarity = @"Legendary";
        return YES;
    }
    
    self.isGolden = YES;
    
    // common g.
    if (random <= 98.211 & random > 96.741) {
        NSLog(@"common GOLDEN");
        self.rarity = @"Common";
        return NO;
    }
    // rare g.
    if (random <= 99.581 & random > 98.211) {
        NSLog(@"rare GOLDEN");
        self.rarity = @"Rare";
        return YES;
    }
    // epic g.
    if (random <= 99.889 & random > 99.581) {
        NSLog(@"epic GOLDEN");
        self.rarity = @"Epic";
        return YES;
    }
    // legend g.
    if (random <= 100 & random > 99.889) {
        NSLog(@"legen GOLDEN");
        self.rarity = @"Legendary";
        return YES;
    }
    return NO;
}


@end
