//
//  BalanceInfo.m
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "BalanceInfo.h"
#import "RewardDataPoint.h"

@interface BalanceInfo ()
@property (nonatomic, strong) NSArray *rewardDataPointsBeforeLastRedeemedDate;
@property (nonatomic, strong) NSArray *rewardDataPointsAfterLastRedeemedDate;
@end

@implementation BalanceInfo

- (void)setRewardDataPoints:(NSArray *)rewardDataPoints
{
    [self splitAndUpdateRewardDataPoints];
}

- (void)setLastRedeemedDate:(NSDate *)lastRedeemedDate
{
    [self splitAndUpdateRewardDataPoints];
}

- (NSNumber *)currentRewardBalance
{
    return [self sumRewardBalancesForRewardDataPoints:self.rewardDataPointsAfterLastRedeemedDate];
}

- (NSNumber *)redeemedRewardBalance
{
    return [self sumRewardBalancesForRewardDataPoints:self.rewardDataPointsBeforeLastRedeemedDate];
}

#pragma mark - Private Methods
- (void)splitAndUpdateRewardDataPoints
{
    if (self.rewardDataPoints != nil && self.lastRedeemedDate != nil) {
        NSMutableArray *beforeDataPoints = [[NSMutableArray alloc] init];
        NSMutableArray *afterDataPoints = [[NSMutableArray alloc] init];

        [self.rewardDataPoints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            RewardDataPoint *reward = obj;
            
            NSComparisonResult comparison = [reward.rewardedDate compare:self.lastRedeemedDate];
            if (comparison == NSOrderedAscending) {
                [beforeDataPoints addObject:reward];
            } else if (comparison == NSOrderedDescending) {
                [afterDataPoints addObject:reward];
            }
        }];
    }
}

- (NSNumber *)sumRewardBalancesForRewardDataPoints:(NSArray *)rewardDataPoints
{
    double total = 0;
    for (RewardDataPoint *reward in rewardDataPoints) {
        total += [reward.rewardedValue doubleValue];
    }
    
    return [NSNumber numberWithDouble:total];
}


@end
