//
//  CardModel+Addition.h
//  Hearthstone
//
//  Created by Admin on 0519//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "CardModel.h"

@interface CardModel (Addition)

+ (CardModel *)checkForCard:(NSString *)pk;

- (void)configureModel:(NSDictionary *)data;

@end
