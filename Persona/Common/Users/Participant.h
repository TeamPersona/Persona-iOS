//
//  Participant.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "User.h"
#import "RewardTierHelper.h"

@interface Participant : User

+ (Participant *)parseDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic) NSInteger totalPoints;

// These properties are generated from the total points above.
@property (nonatomic, readonly) RewardTier rewardTier;
@property (readonly) NSInteger pointsToNextTier;
@property (readonly) NSNumber *tierProgress;

@property (nonatomic) NSNumber *accountBalance; //TODO: Make money class $


@end
