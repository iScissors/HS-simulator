//
//  PackModel.h
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/28/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardModel;

@interface PackModel : NSManagedObject

@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *cards;
@end

@interface PackModel (CoreDataGeneratedAccessors)

- (void)addCardsObject:(CardModel *)value;
- (void)removeCardsObject:(CardModel *)value;
- (void)addCards:(NSSet *)values;
- (void)removeCards:(NSSet *)values;

@end
