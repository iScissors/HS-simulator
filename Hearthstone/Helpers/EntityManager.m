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
#import "CardModel+Addition.h"
#import "PackModel.h"
#import "UNIRest.h"

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
        NSMutableArray *modelArray = [NSMutableArray new];
        for (NSString *item in [EntityManager getDataFromFile:@"Rarity"]) {
            RarityModel *model = [RarityModel MR_createEntity];
            model.rarityType = item;
            [modelArray addObject:model];            
        }
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        NSLog(@"=== All Rarity added ===");
    }
}

+ (void)setPackModelData {
    if ([PackModel MR_findAll].count == 0) {
        NSArray *images = @[@"classicPack", @"gvgPack"];
        NSMutableArray *modelArray = [NSMutableArray new];
        int i = 0;
        for (NSString *item in [EntityManager getDataFromFile:@"Packs"]) {
            PackModel *model = [PackModel MR_createEntity];
            model.type = item;
            model.imageName = images[i];
            [modelArray addObject:model];
            i++;
        }
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        NSLog(@"=== All Packs added ===");
    }
}

+ (void)setCardModelData:(NSString *)pack {

    NSDictionary *headers = @{@"X-Mashape-Key": @"tnrzpmUXIBmshaYtv8WUB2I9nbdXp1EKWmNjsnanl0mfqZQH07"};
    
    [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:[NSString stringWithFormat:@"https://omgvamp-hearthstone-v1.p.mashape.com/cards/sets/%@?collectible=1", pack]];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSLog(@"=== Respose Code: %ld ===", (long)response.code);
        
        NSMutableArray *modelArray = [NSMutableArray new];
        for (NSDictionary *item in response.body.array) {
            CardModel *model = [CardModel checkForCard:item[@"cardId"]];
            [model configureModel:item];
            [modelArray addObject:model];
        }
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        NSLog(@"=== Cards added ===");
    }];
}



@end
