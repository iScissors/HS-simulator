//
//  Card.m
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "Card.h"
#import "UIView+Positioning.h"

#define closedWidth 66
#define openedWidth 70
#define closedHeight 93

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
        [self setImage:[UIImage imageNamed:_frontImage] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            self.width = openedWidth;
            self.x -= openedWidth / 2;
        }];
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cardNotification" object:self];
}

@end
