//
//  ProfileManager.m
//  Persona
//
//  Created by Denny Kim on 2015-07-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileManager.h"
#import "Participant.h"

static const NSString *API_JSON_Root_Profile =           @"profile";

static const NSString *API_JSON_Reward_Tier_Level =         @"tierLevel";
static const NSString *API_JSON_Total_Points =              @"totalPoints";
static const NSString *API_JSON_Points_Until_Next_Tier =    @"pointsUntilNextTier";
static const NSString *API_JSON_Account_Balance =           @"accountBalance";
static const NSString *API_JSON_Total_Offers =              @"totalOffers";

@implementation ProfileManager

+ (Participant *)parseProfileDataFromJSONFile:(NSString *)fileLocation
{
    NSDictionary *json = [super getJSONDataFromFile:fileLocation];
    
    if (json == nil) {
        return nil;
    }
    
    NSDictionary *jsonProfile = json[API_JSON_Root_Profile];
    return [self parseJSONProfileObject:jsonProfile];
}

#pragma mark - Helper Methods
+ (Participant *)parseJSONProfileObject:(NSDictionary *)jsonProfile
{
    Participant *participant = [[Participant alloc] init];
    if (jsonProfile[API_JSON_Reward_Tier_Level] != nil) {
        participant.rewardTier = (RewardTier)[jsonProfile[API_JSON_Reward_Tier_Level] integerValue];
    }
    if (jsonProfile[API_JSON_Total_Points] != nil) {
        participant.totalPointsEarned = jsonProfile[API_JSON_Total_Points];
    }
    if (jsonProfile[API_JSON_Points_Until_Next_Tier] != nil) {
        participant.pointsUntilNextTier = jsonProfile[API_JSON_Points_Until_Next_Tier];
    }
    if (jsonProfile[API_JSON_Account_Balance] != nil) {
        participant.accountBalance = jsonProfile[API_JSON_Account_Balance];
    }
    if (jsonProfile[API_JSON_Total_Offers] != nil) {
        participant.totalNumOffers = jsonProfile[API_JSON_Total_Offers];
    }
    
    return participant;
}

@end
