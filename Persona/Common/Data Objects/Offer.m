//
//  Offer.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "Offer.h"

@interface Offer ()
@property (nonatomic, strong) NSMutableOrderedSet *_missingInfoSet;
@end

@implementation Offer

- (id)init
{
    self = [super init];
    if (self) {
        self._missingInfoSet = [[NSMutableOrderedSet alloc] init];
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

- (void)setInfoFilterList:(NSArray *)infoFilterList
{
    _infoFilterList = infoFilterList;

    for (NSDictionary *info in _infoFilterList) {
        if ([info[@"informationMissing"] boolValue]) {
            [self._missingInfoSet addObject:info[@"informationType"]];
        }
    }
}

- (void)setInfoRequiredList:(NSArray *)infoRequiredList
{
    _infoRequiredList = infoRequiredList;
    
    for (NSDictionary *info in _infoRequiredList) {
        if ([info[@"informationMissing"] boolValue]) {
            [self._missingInfoSet addObject:info[@"informationType"]];
        }
    }
}

- (BOOL)isEligible
{
    return (self._missingInfoSet.count == 0);
}

- (BOOL)isExpired
{
    return (self.expirationDate.timeIntervalSince1970 < [NSDate date].timeIntervalSince1970);
}

- (NSArray *)missingInformationCategories
{
    [self._missingInfoSet sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    return self._missingInfoSet.array;
}

@end
