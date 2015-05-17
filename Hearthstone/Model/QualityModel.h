//
//  QualityModel.h
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AbstractModel.h"

@class CardModel;

@interface QualityModel : AbstractModel

@property (nonatomic, retain) NSNumber * golden;
@property (nonatomic, retain) NSSet *cards;
@end

@interface QualityModel (CoreDataGeneratedAccessors)

- (void)addCardsObject:(CardModel *)value;
- (void)removeCardsObject:(CardModel *)value;
- (void)addCards:(NSSet *)values;
- (void)removeCards:(NSSet *)values;

@end
