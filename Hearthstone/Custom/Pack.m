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
    
    NSLog(@"=== Opening begins ... ===");
    self.hidden = YES;
    NSArray *positions = @[[NSValue valueWithCGPoint:CGPointMake(295, 40)],
                           [NSValue valueWithCGPoint:CGPointMake(370, 85)],
                           [NSValue valueWithCGPoint:CGPointMake(335, 190)],
                           [NSValue valueWithCGPoint:CGPointMake(255, 190)],
                           [NSValue valueWithCGPoint:CGPointMake(220, 85)]];
    
    BOOL anyRare = NO;
    for (int i = 0; i < 5; i++) {
        Card *card = [[Card alloc] initWithBack:@"ninjaCardBack"];
        card.origin = [positions[i] CGPointValue];
        [self.superview addSubview:card];
        
        if ([card rollRarity]) anyRare = YES;

        while (!anyRare && i == 4) {
            anyRare = [card rollRarity];
        }
        [card rollCard];
    }
}

@end
