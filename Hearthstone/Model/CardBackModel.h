//
//  CardBackModel.h
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/31/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CardBackModel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * image;

@end
