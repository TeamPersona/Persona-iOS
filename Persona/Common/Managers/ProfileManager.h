//
//  ProfileManager.h
//  Persona
//
//  Created by Denny Kim on 2015-07-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONManager.h"
#import "Participant.h"

static const NSString *API_JSON_Root_Profile =           @"profile";

static const NSString *API_JSON_Reward_Tier_Level = @"tierLevel";
static const NSString *API_JSON_Total_Points =      @"totalPoints";
static const NSString *API_JSON_Account_Balance =   @"accountBalance";
static const NSString *API_JSON_Total_Offers =      @"totalOffers";

@interface ProfileManager : JSONManager

+ (Participant *)parseProfileDataFromJSONFile:(NSString *)fileLocation;

@end
