//
//  UserModel.h
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/29/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardModel;

@interface UserModel : NSManagedObject

@property (nonatomic, retain) NSNumber * commonCount;
@property (nonatomic, retain) NSNumber * rareCount;
@property (nonatomic, retain) NSNumber * epicCount;
@property (nonatomic, retain) NSNumber * legendaryCount;
@property (nonatomic, retain) NSNumber * commonGoldCount;
@property (nonatomic, retain) NSNumber * rareGoldCount;
@property (nonatomic, retain) NSNumber * epicGoldCount;
@property (nonatomic, retain) NSNumber * legendaryGoldCount;
@property (nonatomic, retain) NSNumber * openedPacks;
@property (nonatomic, retain) NSSet *cards;
@end

@interface UserModel (CoreDataGeneratedAccessors)

- (void)addCardsObject:(CardModel *)value;
- (void)removeCardsObject:(CardModel *)value;
- (void)addCards:(NSSet *)values;
- (void)removeCards:(NSSet *)values;

@end
