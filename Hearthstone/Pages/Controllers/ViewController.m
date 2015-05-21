//
//  ViewController.m
//  Hearthstone
//
//  Created by Admin on 0515//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "ViewController.h"
#import "Pack.h"
#import "Card.h"
#import "UIView+Positioning.h"
#import "MagicalRecord.h"
#import "ShopViewController.h"

#define animation 0.3

@interface ViewController ()

@property (strong, nonatomic) Pack *pack;

@property (nonatomic) BOOL packIsActive;

@property (nonatomic) NSInteger openedCards;

@end

@implementation ViewController

#pragma mark Initialization

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.packIsActive = YES;
    [self createPack];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkForLastCard)
                                                 name:@"cardNotification"
                                               object:nil];
}


#pragma mark Game logic

- (void)createPack {
    
    self.pack = [[Pack alloc] initWithPack:@"gvgPack"];
    [self.view addSubview:self.pack];
    self.packIsActive = YES;
}

- (void)checkForLastCard {
    
    if (self.openedCards == 4) {
        UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
        done.tag = 1;
        [done addTarget:self action:@selector(pressDone) forControlEvents:UIControlEventTouchUpInside];
        done.size = CGSizeMake(55, 30);
        [done setImage:[UIImage imageNamed:@"doneButton"] forState:UIControlStateNormal];
        done.origin = CGPointMake(300, self.view.centerY - 12);
        [self.view addSubview:done];
    }
    else {
        self.openedCards++;
    }
}

- (void)pressDone {
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[Card class]]) {
            [UIView animateWithDuration:0.3 animations:^{
                [(Card *)view setAlpha:0];
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }
    }
    UIView *doneButton = [self.view viewWithTag:1];
    [UIView animateWithDuration:0.2 animations:^{
        [doneButton setAlpha:0];
    } completion:^(BOOL finished) {
        [doneButton removeFromSuperview];
    }];
    doneButton = nil;
    self.packIsActive = NO;
    self.openedCards = 0;
}

#pragma mark View buttons

- (IBAction)resetPack:(id)sender {
    
    if (!self.packIsActive) {
        [self.pack removeFromSuperview];
        self.pack = nil;
        [self createPack];
    }
}

@end
