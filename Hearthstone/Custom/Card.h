//
//  Card.h
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, rarity) {
    common = 0,
    rare,
    epic,
    legendary
};

@interface Card : UIButton

@property (strong, nonatomic) NSString *frontImage;

@property (nonatomic) NSInteger rariry;


- (id)initWithBack:(NSString *)back;

- (void)turnCard;

@end
