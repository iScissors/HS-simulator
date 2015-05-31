//
//  CardBackModel+Addition.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/31/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "CardBackModel+Addition.h"
#import "CoreData+MagicalRecord.h"

@implementation CardBackModel (Addition)

+ (NSArray *)setupModels:(NSMutableArray *)array {
    
    NSMutableArray *result = [NSMutableArray new];
    
    NSArray *tempData = [array[2] allObjects];
    [array removeObjectAtIndex:2];
    for (NSArray *item in tempData) {
        [array addObject:item];
    }
    
    for (NSArray *topArray in array) {
        for (NSDictionary *dict in topArray) {
            if (![CardBackModel MR_findFirstByAttribute:@"name" withValue:dict[@"name"]]) {
                CardBackModel *model = [CardBackModel MR_createEntity];
                model.name = dict[@"name"];
                model.image = dict[@"img"];
                [result addObject:model];
            }
        }
    }
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    
    return result;
}

@end
