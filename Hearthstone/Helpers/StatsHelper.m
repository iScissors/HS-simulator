//
//  StatsHelper.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/27/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "StatsHelper.h"
#import "UIView+Positioning.h"

@interface StatsHelper()

@property (strong, nonatomic) UIButton *flagButton;

@property (strong, nonatomic) UIImageView *content;

@property (getter=isOpen) BOOL open;

@end

@implementation StatsHelper

- (id)initWithView:(UIView *)view {
    self = [super init];
    if(self) {
        [self configureStatMenu:view];
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
    // add 1 + 4 labels
    
    return content;
}

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

@end
