//
//  ShopView.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/20/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "ShopView.h"
#import "UIView+Positioning.h"

@implementation ShopView

- (id)init {
    
    self = [super init];
    if (self) {
        self.size = CGSizeMake(350, 230);
        self.backgroundColor = [UIColor redColor];    
    }
    
    return self;
}

@end
