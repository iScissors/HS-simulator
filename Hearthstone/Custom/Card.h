//
//  Card.h
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackModel.h"


@interface Card : UIButton

@property (strong, nonatomic) CardModel *cardModel;

@property (nonatomic) NSString *rarity;

@property (nonatomic) BOOL isGolden;


- (id)initWithBack:(NSString *)back;

- (BOOL)rollRarity;

- (void)rollCard:(PackModel *)packType;

@end
