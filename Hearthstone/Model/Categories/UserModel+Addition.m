//
//  UserModel+Addition.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/30/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "UserModel+Addition.h"
#import "CoreData+MagicalRecord.h"

@implementation UserModel (Addition)

+ (NSDictionary *)getPropertiesByRarity:(NSString *)rarity {
    
    UserModel *user = [UserModel MR_findFirst];
    NSMutableDictionary *dict = [@{@"first": @"", @"second": @""} mutableCopy];
    
    if ([rarity isEqualToString:@"Common"]) {
        dict[@"first"] = user.commonCount;
        dict[@"second"] = user.commonGoldCount;
        return dict;
    }
    if ([rarity isEqualToString:@"Rare"]) {
        dict[@"first"] = user.rareCount;
        dict[@"second"] = user.rareGoldCount;
        return dict;
    }
    if ([rarity isEqualToString:@"Epic"]) {
        dict[@"first"] = user.epicCount;
        dict[@"second"] = user.epicGoldCount;
        return dict;
    }
    if ([rarity isEqualToString:@"Legendary"]) {
        dict[@"first"] = user.legendaryCount;
        dict[@"second"] = user.legendaryGoldCount;
        return dict;
    }
    
    return dict;
}

+ (void)updatePropertiesByRarity:(NSString *)rarity isGolden:(BOOL)flag {
    
    UserModel *user = [UserModel MR_findFirst];
    
    if ([rarity isEqualToString:@"Common"]) {
        if (flag)
            user.commonGoldCount = @(user.commonGoldCount.integerValue + 1);
        else
            user.commonCount = @(user.commonCount.integerValue + 1);
        return;
    }
    if ([rarity isEqualToString:@"Rare"]) {
        if (flag)
            user.rareGoldCount = @(user.rareGoldCount.integerValue + 1);
        else
            user.rareCount = @(user.rareCount.integerValue + 1);
        return;
    }
    if ([rarity isEqualToString:@"Epic"]) {
        if (flag)
            user.epicGoldCount = @(user.epicGoldCount.integerValue + 1);
        else
            user.epicCount = @(user.epicCount.integerValue + 1);
        return;
    }
    if ([rarity isEqualToString:@"Legendary"]) {
        if (flag)
            user.legendaryGoldCount = @(user.legendaryGoldCount.integerValue + 1);
        else
            user.legendaryCount = @(user.legendaryCount.integerValue + 1);
        return;
    }
}

@end
