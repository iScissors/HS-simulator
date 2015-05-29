//
//  CardModel.h
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/29/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PackModel, RarityModel, UserModel;

@interface CardModel : NSManagedObject

@property (nonatomic, retain) NSString * cardId;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * imageGolden;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * ownedAmount;
@property (nonatomic, retain) PackModel *packType;
@property (nonatomic, retain) RarityModel *rarity;
@property (nonatomic, retain) UserModel *user;

@end
