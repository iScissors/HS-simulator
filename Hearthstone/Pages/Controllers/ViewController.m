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
#import "StatsHelper.h"
#import "UIView+Positioning.h"
#import "CoreData+MagicalRecord.h"
#import "MagicalRecord.h"
#import "ShopViewController.h"

#define SegueName @"ShopSegue"
#define animation 0.3

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mainScreen;

@property (strong, nonatomic) Pack *pack;

@property (nonatomic) BOOL packIsActive;	

@property (nonatomic) NSInteger openedCards;

@property (nonatomic) StatsHelper *statsHelper;

@end

@implementation ViewController

#pragma mark Initialization

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.packIsActive = NO;
    
    self.statsHelper = [[StatsHelper alloc] initWithView:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkForLastCard)
                                                 name:@"cardNotification"
                                               object:nil];
}

#pragma mark Game logic

- (void)createPack {
    
    if (!self.packIsActive) {
        self.pack = [[Pack alloc] initWithPack:self.packModel];
        [self.view addSubview:self.pack];
        self.packIsActive = YES;
    }
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
    
    if (!self.packIsActive && self.packModel != nil) {
        [self.pack removeFromSuperview];
        self.pack = nil;
        [self createPack];
    }
}

- (IBAction)openShop:(id)sender {
    
    if (!self.packIsActive) {
        UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        alphaView.backgroundColor = [UIColor blackColor];
        alphaView.alpha = 0;
        [self.view addSubview:alphaView];
        [UIView animateWithDuration:0.5 animations:^{
            alphaView.alpha = 0.6;
        }];
        [self performSegueWithIdentifier:SegueName sender:self];
    }
}

#pragma mark Support

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueName]) {
        ShopViewController *modalVC = [segue destinationViewController];
        modalVC.delegate = self;
    }
}

- (void)dismissBlur {
    
    if ([self.packModel.type isEqualToString:@"Classic"])
        [self.mainScreen setImage:[UIImage imageNamed:@"classicBackground"]];
    
    if ([self.packModel.type isEqualToString:@"Goblins vs Gnomes"])
        [self.mainScreen setImage:[UIImage imageNamed:@"gvgBackground"]];
    
    UIView *alphaView = self.view.subviews.lastObject;
    [UIView animateWithDuration:0.5 animations:^{
        alphaView.alpha = 0;
    } completion:^(BOOL finished) {
        [alphaView removeFromSuperview];
    }];
}


@end
