//
//  Participant.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "Participant.h"

@implementation Participant

+ (Participant *)parseDictionary:(NSDictionary *)dictionary
{
    Participant *participant = [Participant new];
    participant.userId = [dictionary[@"id"] integerValue];
    participant.name = [NSString stringWithFormat:@"%@ %@", dictionary[@"givenName"], dictionary[@"familyName"]];
    participant.emailAddress = dictionary[@"emailAddress"];
    participant.phoneNumber = dictionary[@"phoneNumber"];
    participant.totalPoints = [dictionary[@"rewardPoints"] integerValue];
    participant.accountBalance = dictionary[@"balance"];

    return participant;
}

- (RewardTier)rewardTier
{
    return [RewardTierHelper rewardTierForPointsValue:self.totalPoints];
}

- (NSInteger)pointsToNextTier
{
    return [RewardTierHelper pointsRemainingToNextTier:self.totalPoints];
}

- (NSNumber *)tierProgress
{
    return [NSNumber numberWithFloat:(float) self.totalPoints / (float) (self.pointsToNextTier + self.totalPoints)];
}

@end
