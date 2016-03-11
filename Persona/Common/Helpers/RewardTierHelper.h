//
//  RewardTierHelper.h
//  Persona
//
//  Created by Denny Kim on 2016-03-10.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RewardTier) {
    RewardTierDefault,
    RewardTierSilver,
    RewardTierGold
};

@interface RewardTierHelper : NSObject

+ (NSInteger)pointsRemainingToNextTier:(NSInteger)currentPoints;
+ (RewardTier)rewardTierForPointsValue:(NSInteger)points;

@end
