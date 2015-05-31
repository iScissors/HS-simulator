//
//  EntityManager.h
//  Hearthstone
//
//  Created by Admin on 0518//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntityManager : NSObject

+ (void)setRarityModelData;

+ (void)setPackModelData;

+ (void)setCardBacksData;

+ (void)setCardModelData:(NSString *)pack;

+ (void)setUserModel;

+ (void)resetUserStats;

+ (void)saveAllData;

@end
