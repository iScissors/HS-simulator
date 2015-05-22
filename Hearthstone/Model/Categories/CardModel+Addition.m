//
//  CardModel+Addition.m
//  Hearthstone
//
//  Created by Admin on 0519//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "CardModel+Addition.h"
#import "RarityModel.h"
#import "PackModel.h"
#import "CoreData+MagicalRecord.h"

@implementation CardModel (Addition)

+ (CardModel *)checkForCard:(NSString *)pk {
    
    CardModel *model = [CardModel MR_findFirstByAttribute:@"cardId" withValue:pk];
    if (!model) {
        model = [CardModel MR_createEntity];
        model.cardId = pk;
    }
    return model;
}

- (void)configureModel:(NSDictionary *)data {
    
    self.name = data[@"name"];
    
    self.rarity = (!self.rarity ? [RarityModel MR_findFirstWithPredicate:
                                   [NSPredicate predicateWithFormat:@"self.rarityType == %@", data[@"rarity"]]] : self.rarity);
    self.packType = (!self.packType ? [PackModel MR_findFirstWithPredicate:
                                   [NSPredicate predicateWithFormat:@"self.type == %@", data[@"cardSet"]]] : self.packType);

    self.image = data[@"img"];
    self.imageGolden = data[@"imgGold"];
}

@end
