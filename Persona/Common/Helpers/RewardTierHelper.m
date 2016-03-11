//
//  RewardTierHelper.m
//  Persona
//
//  Created by Denny Kim on 2016-03-10.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "RewardTierHelper.h"

@implementation RewardTierHelper

+ (NSInteger)pointsRemainingToNextTier:(NSInteger)currentPoints
{
    if (currentPoints >= [RewardTierHelper minPointsForTier:RewardTierGold]) {
        return 0;
    } else if (currentPoints >= [RewardTierHelper minPointsForTier:RewardTierSilver]) {
        return [RewardTierHelper minPointsForTier:RewardTierGold] - currentPoints;
    } else {
        return [RewardTierHelper minPointsForTier:RewardTierSilver] - currentPoints;
    }
}

+ (RewardTier)rewardTierForPointsValue:(NSInteger)points
{
    if (points >= [RewardTierHelper minPointsForTier:RewardTierDefault] &&
        points < [RewardTierHelper minPointsForTier:RewardTierSilver]) {
        return RewardTierDefault;
    } else if (points >= [RewardTierHelper minPointsForTier:RewardTierSilver] &&
               points < [RewardTierHelper minPointsForTier:RewardTierGold]) {
        return RewardTierSilver;
    } else {
        return RewardTierGold;
    }
}

+ (NSInteger)minPointsForTier:(RewardTier)tier
{
    if (tier == RewardTierDefault) {
        return 0;
    } else if (tier == RewardTierSilver) {
        return 250;
    } else {
        return 1000;
    }
}

@end
