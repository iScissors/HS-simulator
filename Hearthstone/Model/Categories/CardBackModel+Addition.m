//
//  CardBackModel+Addition.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 08/10/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "CardBackModel+Addition.h"

@implementation CardBackModel (Addition)

- (void)configureModel:(NSDictionary *)data {
    
    self.cardBackId = @([data[@"cardBackId"] integerValue]);
    self.name = data[@"name"];
    self.image = data[@"img"];
    self.imageAnimated = data[@"imgAnimated"];
}

@end
