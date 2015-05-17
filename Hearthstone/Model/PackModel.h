//
//  PackModel.h
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AbstractModel.h"

@class CardModel;

@interface PackModel : AbstractModel

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *cards;
@end

@interface PackModel (CoreDataGeneratedAccessors)

- (void)addCardsObject:(CardModel *)value;
- (void)removeCardsObject:(CardModel *)value;
- (void)addCards:(NSSet *)values;
- (void)removeCards:(NSSet *)values;

@end
