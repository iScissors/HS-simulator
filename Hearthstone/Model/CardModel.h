//
//  CardModel.h
//  Hearthstone
//
//  Created by Admin on 0516//15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CardModel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *rarity;
@property (nonatomic, retain) NSManagedObject *quality;
@property (nonatomic, retain) NSManagedObject *packType;

@end
