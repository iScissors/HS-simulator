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
#import "UIImage+animatedGIF.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define closedWidth 66
#define openedWidth 80
#define closedHeight 93

@interface Card()

@property (strong, nonatomic) UIImage *frontImage;

@property (strong, nonatomic) NSString *sound;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

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
    
    if (self.sound) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"MR data" ofType:@"bundle"];
            NSString *path = [NSString stringWithFormat:@"%@/%@.wav", bundlePath, self.sound];
            NSURL *soundUrl = [NSURL fileURLWithPath:path];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
            [self.audioPlayer play];
        });
    }
    
    float newSize = 1.2579;
    float cardBottom = self.bottom;
    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.width = 0;
        self.x += closedWidth / 2;
    } completion:^(BOOL finished) {
        self.height *= newSize;
        self.bottom = cardBottom + 0.065 * self.height;
        [self setImage:_frontImage forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            self.width = openedWidth;
            self.x -= openedWidth / 2;
        }];
        [self startFloating];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cardOpened" object:self];
}

- (void)rollCard:(PackModel *)packType {
   
    RarityModel *rarity = [RarityModel MR_findFirstByAttribute:@"rarityType" withValue:self.rarity];
    NSArray *cardsArray = [CardModel MR_findAllWithPredicate:
                           [NSPredicate predicateWithFormat:@"packType == %@ AND rarity == %@", packType, rarity]];
    self.cardModel = [cardsArray objectAtIndex:arc4random_uniform((uint)cardsArray.count)];
    
    // Image request
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", (self.isGolden ? self.cardModel.imageGolden : self.cardModel.image)]];
        if (self.isGolden)
            self.frontImage = [UIImage animatedImageWithAnimatedGIFURL:url];
        else {
            NSData *data = [NSData dataWithContentsOfURL:url];
            self.frontImage = [UIImage imageWithData:data];
        }
        NSLog(@"=== Card image loaded ===");
    });
}

- (void)startFloating {
    
    [UIView animateKeyframesWithDuration:3 delay:0
                                 options:UIViewKeyframeAnimationOptionRepeat | UIViewKeyframeAnimationOptionAutoreverse
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:1
                                                                animations:^{
                                                                    self.x += 1.5;
                                                                    self.y -= 2;
                                  }];
                              } completion:nil];
}

- (BOOL)rollRarity {
    
    float random = arc4random_uniform(100001);
    random /= 1000;
    
    self.isGolden = NO;
    
    // common
    if (random <= 69.981) {
        NSLog(@"random = %f - common", random);
        self.rarity = @"Common";
        return NO;
    }
    // rare
    if (random <= 91.381 & random > 69.981) {
        NSLog(@"random = %f - rare", random);
        self.sound = @"rare";
        self.rarity = @"Rare";
        return YES;
    }
    // epic
    if (random <= 95.661 & random > 91.381) {
        NSLog(@"random = %f - epic", random);
        self.sound = @"epic";
        self.rarity = @"Epic";
        return YES;
    }
    //legend
    if (random <= 96.741 & random > 95.661) {
        NSLog(@"random = %f - legendary", random);
        self.sound = @"legendary";
        self.rarity = @"Legendary";
        return YES;
    }
    
    self.isGolden = YES;
    
    // common g.
    if (random <= 98.211 & random > 96.741) {
        NSLog(@"random = %f - GOLDEN common", random);
        self.sound = @"common_golden";
        self.rarity = @"Common";
        return NO;
    }
    // rare g.
    if (random <= 99.581 & random > 98.211) {
        NSLog(@"random = %f - GOLDEN rare", random);
        self.sound = @"rare_golden";
        self.rarity = @"Rare";
        return YES;
    }
    // epic g.
    if (random <= 99.889 & random > 99.581) {
        NSLog(@"random = %f - GOLDEN epic", random);
        self.sound = @"epic_golden";
        self.rarity = @"Epic";
        return YES;
    }
    // legend g.
    if (random <= 100 & random > 99.889) {
        NSLog(@"random = %f - GOLDEN legendary", random);
        self.sound = @"legendary_golden";
        self.rarity = @"Legendary";
        return YES;
    }
    return NO;
}


@end
