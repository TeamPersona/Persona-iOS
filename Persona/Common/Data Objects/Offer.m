//
//  Offer.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "Offer.h"

@interface Offer ()
@property (nonatomic, strong) NSMutableOrderedSet *_missingCategoriesSet;
@end

@implementation Offer

- (id)init
{
    self = [super init];
    if (self) {
        self._missingCategoriesSet = [[NSMutableOrderedSet alloc] init];
    }
    return self;
}

- (NSString *)rewardString
{
    return [NSString stringWithFormat:@"$%.02lf", [self.rewardValue doubleValue]];
}

- (CGFloat)participantsProgress
{
    return (CGFloat)self.currentParticipants / (CGFloat)self.totalParticipants;
}

- (void)setCategoryFilterList:(NSDictionary *)categoryFilterList
{
    _categoryFilterList = categoryFilterList;
    
    for (NSString *categoryName in _categoryFilterList.allKeys) {
        if ([_categoryFilterList[categoryName] boolValue]) {
            [self._missingCategoriesSet addObject:categoryName];
        }
    }
}

- (void)setCategoryRequestedList:(NSDictionary *)categoryRequestedList
{
    _categoryRequestedList = categoryRequestedList;
    
    for (NSString *categoryName in _categoryRequestedList.allKeys) {
        if ([_categoryRequestedList[categoryName] boolValue]) {
            [self._missingCategoriesSet addObject:categoryName];
        }
    }
}

- (BOOL)isEligible
{
    return (self._missingCategoriesSet.count == 0);
}

- (BOOL)isExpired
{
    return (self.expirationDate.timeIntervalSince1970 < [NSDate date].timeIntervalSince1970);
}

- (NSArray *)missingInformationCategories
{
    [self._missingCategoriesSet sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    return self._missingCategoriesSet.array;
}

@end
