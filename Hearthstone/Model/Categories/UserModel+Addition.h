//
//  UserModel+Addition.h
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/30/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "UserModel.h"

@interface UserModel (Addition)

+ (NSDictionary *)getPropertiesByRarity:(NSString *)rarity;

+ (void)updatePropertiesByRarity:(NSString *)rarity isGolden:(BOOL)flag;

@end
