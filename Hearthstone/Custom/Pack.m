//
//  Pack.m
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "Pack.h"
#import "Card.h"
#import "UIView+Positioning.h"

#define closedWidth 66
#define closedHeight 93

@implementation Pack

- (id)initWithPack:(NSString *)packType {
    self = [super init];
    if (self) {
        self = [Pack buttonWithType:UIButtonTypeCustom];
        self.size = CGSizeMake(closedWidth, closedHeight);
        self.origin = CGPointMake(295, 110);
        self.backgroundColor = [UIColor clearColor];
        [self setImage:[UIImage imageNamed:packType] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(openPack) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)openPack {
    
    self.hidden = YES;
    
    NSArray *positions = @[[NSValue valueWithCGPoint:CGPointMake(295, 40)],
                           [NSValue valueWithCGPoint:CGPointMake(370, 85)],
                           [NSValue valueWithCGPoint:CGPointMake(335, 190)],
                           [NSValue valueWithCGPoint:CGPointMake(255, 190)],
                           [NSValue valueWithCGPoint:CGPointMake(220, 85)]];
    
    for (int i = 0; i < 5; i++) {
        Card *card = [[Card alloc] initWithBack:@"ninjaCardBack"];
        card.origin = [positions[i] CGPointValue];
        [self.superview addSubview:card];
        
        [self rollCard:card];
    }
}

- (void)rollCard:(Card *)card{
    float random = arc4random() % 100000 + 1;
    random /= 1000;
    
    NSLog(@"random = %f", random);
    NSString *background;
    
    // common
    if (random <= 69.981) {
        NSLog(@"common");
        card.rariry = common;
    }
    // rare
    if (random <= 91.381 & random > 69.981) {
        NSLog(@"rare");
        card.rariry = rare;
    }
    // epic
    if (random <= 95.661 & random > 91.381) {
        NSLog(@"epic");
        card.rariry = epic;
    }
    //legend
    if (random <= 96.741 & random > 95.661) {
        NSLog(@"legen");
        card.rariry = legendary;
    }
    
    // common g.
    if (random <= 98.211 & random > 96.741) {
        NSLog(@"common GOLDEN");
        card.rariry = common;
    }
    // rare g.
    if (random <= 99.581 & random > 98.211) {
        NSLog(@"rare GOLDEN");
        card.rariry = rare;
    }
    // epic g.
    if (random <= 99.889 & random > 99.581) {
        NSLog(@"epic GOLDEN");
        card.rariry = epic;
    }
    // legend g.
    if (random <= 100 & random > 99.889) {
        NSLog(@"legen GOLDEN");
        card.rariry = legendary;
    }
    
    [card setFrontImage:@"test"]; // background];
}

@end
