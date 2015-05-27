//
//  StatsHelper.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/27/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "StatsHelper.h"
#import "UIView+Positioning.h"

@implementation StatsHelper

static  BOOL isOpen;

+ (void)configureStatMenu:(UIView *)view {
    
    isOpen = NO;
    
    UIButton *flagButton = [self createFlagButton];
    [view addSubview:flagButton];
    [UIView animateWithDuration:0.5  animations:^{
        flagButton.y = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            flagButton.y -= 3;
        }];
    }];

    [view addSubview:[self createContent]];
}

+ (UIButton *)createFlagButton {
    
    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    flagButton.size = CGSizeMake(48, 65);
    flagButton.origin = CGPointMake(490, 0 - flagButton.height);
    flagButton.backgroundColor = [UIColor clearColor];
    [flagButton setImage:[UIImage imageNamed:@"flagButton"] forState:UIControlStateNormal];
    flagButton.adjustsImageWhenHighlighted = NO;
    [flagButton addTarget:self action:@selector(toggleContent) forControlEvents:UIControlEventTouchUpInside];
    
    return flagButton;
}

+ (UIView *)createContent {
    
    return nil;
}

+ (void)toggleContent {
    
    if (isOpen) {
        // close
        isOpen = NO;
    }
    else {
        // open
        isOpen = YES;
    }
}

@end
