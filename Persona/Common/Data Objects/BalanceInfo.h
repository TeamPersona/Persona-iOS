//
//  BalanceInfo.h
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RewardDataPoint.h"

@interface BalanceInfo : NSObject

@property (nonatomic, strong) NSDate *lastRedeemedDate;
@property (nonatomic, strong) NSArray *rewardDataPoints;
@property (nonatomic, readonly) NSNumber *currentRewardBalance;
@property (nonatomic, readonly) NSNumber *redeemedRewardBalance;

@end
