//
//  Card.h
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Card : UIButton

- (id)initWithBack:(NSString *)back;

- (BOOL)rollRarity;

- (void)rollCard;

- (void)turnCard;

@end
