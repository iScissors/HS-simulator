//
//  EntityManager.m
//  Hearthstone
//
//  Created by Admin on 0518//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "EntityManager.h"
#import "CoreData+MagicalRecord.h"
#import "RarityModel.h"
#import "QualityModel.h"
#import "PackModel.h"

@implementation EntityManager

+ (NSArray *)getDataFromFile:(NSString *)fileName {
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"MR data" ofType:@"bundle"];
    NSString *bundleFile = [[NSBundle bundleWithPath:bundlePath] pathForResource:fileName ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:bundleFile
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    NSArray *data = [[NSArray alloc]initWithArray:[string componentsSeparatedByString:@"\n"]];
    
    return data;
}

+ (void)setRarityModelData {
    
    if ([RarityModel MR_findAll].count == 0) {
        for (NSString *item in [EntityManager getDataFromFile:@"Rarity"]) {
            RarityModel *model = [RarityModel MR_createEntity];
            model.rarityType = item;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        NSLog(@"=== All Rarity added ===");
    }
}

+ (void)setQualityModelData {
    if ([QualityModel MR_findAll].count == 0) {        
        for (int i = 0; i < 2; i++) {
            QualityModel *model = [QualityModel MR_createEntity];
            model.golden = (i == 0 ? @NO : @YES);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        NSLog(@"=== All Quality added ===");
    }
}

+ (void)setPackModelData {
    if ([PackModel MR_findAll].count == 0) {
        for (NSString *item in [EntityManager getDataFromFile:@"Packs"]) {
            PackModel *model = [PackModel MR_createEntity];
            model.type = item;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        NSLog(@"=== All Packs added ===");
    }
}

+ (void)setCardModelData {
//    if ([PackModel MR_findAll].count == 0) {
//        for (NSString *item in [EntityManager getDataFromFile:@"Packs"]) {
//            PackModel *model = [PackModel MR_createEntity];
//            model.type = item;
//            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//        }
//        NSLog(@"=== All Cards added ===");
//    }
}


@end
