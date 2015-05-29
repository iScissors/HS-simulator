//
//  StatsHelper.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/27/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "StatsHelper.h"
#import "Card.h"
#import "UIView+Positioning.h"
#import "CoreData+MagicalRecord.h"
#import "CardModel.h"

@interface StatsHelper()

@property (strong, nonatomic) UIButton *flagButton;

@property (strong, nonatomic) UIImageView *content;

@property (strong, nonatomic) UILabel *packLabel;

@property (getter=isOpen) BOOL open;

@property (nonatomic) NSArray *labelsArray;

@end

@implementation StatsHelper

#pragma mark Initialization

- (id)initWithView:(UIView *)view {
    self = [super init];
    if(self) {
        [self configureStatMenu:view];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateStats:)
                                                     name:@"cardOpened"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePackCount)
                                                     name:@"packOpened"
                                                   object:nil];
    }
    return self;
}

- (void)configureStatMenu:(UIView *)view {
    
    self.flagButton = [self createFlagButton];
    [view addSubview:self.flagButton];
    [UIView animateWithDuration:0.5  animations:^{
        self.flagButton.y = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.flagButton.y -= 3;
        }];
    }];

    self.content = [self createContent];
    [view addSubview:self.content];
}

#pragma mark Creating objects

- (UIButton *)createFlagButton {
    
    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    flagButton.size = CGSizeMake(48, 65);
    flagButton.origin = CGPointMake(487, 0 - flagButton.height);
    flagButton.backgroundColor = [UIColor clearColor];
    [flagButton setImage:[UIImage imageNamed:@"flagButton"] forState:UIControlStateNormal];
    flagButton.adjustsImageWhenHighlighted = NO;
    [flagButton addTarget:self action:@selector(toggleContent) forControlEvents:UIControlEventTouchUpInside];
    
    return flagButton;
}

- (UIImageView *)createContent {
    
    UIImageView *content = [UIImageView new];
    content.size = CGSizeMake(114, 135);
    content.centerX = self.flagButton.centerX;
    content.y = -content.height;
    content.image = [UIImage imageNamed:@"paperBackground"];
    
    self.packLabel = [self createContLabel:CGRectMake(55, 43, 30, 10)];
    [content addSubview:self.packLabel];
    
    self.labelsArray = @[[@{@"rarity": @"Common", @"label": @""} mutableCopy],
                         [@{@"rarity": @"Rare", @"label": @""} mutableCopy],
                         [@{@"rarity": @"Epic", @"label": @""} mutableCopy],
                         [@{@"rarity": @"Legendary", @"label": @""} mutableCopy]];
    
    NSInteger space = 16;
    for (int i = 1; i < 5; i++) {
        UILabel *label = [self createContLabel:CGRectMake(75, 39 + i * space, 30, 10)];
        [content addSubview:label];
        [self.labelsArray[i-1] setObject:label forKey:@"label"];
    }
    
    return content;
}

#pragma mark Animating

- (void)toggleContent {
    
    if (self.isOpen) {
        self.open = NO;
        [self animateToggleUp:NO];
    }
    else {
        self.open = YES;
        [self animateToggleUp:YES];
    }
}

- (void)animateToggleUp:(BOOL)flag {
    
    NSInteger hideValue = 14;
    NSInteger flagHide = 6;
    NSInteger multiply = (flag ? 1 : -1);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.flagButton.y -= multiply * (flag ? flagHide : hideValue);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.flagButton.y += (self.content.height + 3) * multiply;
            self.content.y += self.content.height * multiply;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.flagButton.y -= multiply * (flag ? hideValue : flagHide);
            }];
        }];
    }];
}

#pragma mark Support 

- (void)updateStats:(NSNotification *)item {
    
    Card *card = (Card *)item.object;
    for (NSDictionary *item in self.labelsArray) {
        if ([card.rarity isEqualToString:item[@"rarity"]]) {
            UILabel *label = item[@"label"];
//            label.text = (card.isGolden ?  : );
//            
//            [(UILabel *)item[@"label"] setText:<#(NSString *)#>]
            break;
        }
    }
}

- (void)updatePackCount {
    
    // label +1
}

- (UILabel *)createContLabel:(CGRect)rect {
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    [label setFont:[UIFont fontWithName:@"Belwe-Bold" size:9]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setText:@"123/5"]; // from model ?
    label.textColor = [UIColor blackColor];
    
    return label;
}

@end
