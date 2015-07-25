//
//  BalanceManager.m
//  Persona
//
//  Created by Denny Kim on 2015-07-25.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "BalanceManager.h"

static NSString *API_JSON_Root_Balance_Info = @"profileBalanceInfo";

static NSString *API_JSON_Last_Redeemded_Date =                 @"lastRedeemedDate";
static NSString *API_JSON_Balance_Info_Data_Points =            @"dataPoints";
static NSString *API_JSON_Balance_Info_Reward_Offer_Id =        @"offerId";
static NSString *API_JSON_Balance_Info_Reward_Date =            @"rewardDate";
static NSString *API_JSON_Balance_Info_Reward_Reward_Value =    @"rewardValue";

@implementation BalanceManager

+ (BalanceInfo *)parseBalanceInfoFromJSONFile:(NSString *)fileLocation
{
    NSDictionary *json = [super getJSONDataFromFile:fileLocation];
    
    if (json == nil) {
        return nil;
    }
    
    NSDictionary *jsonBalanceInfo = json[API_JSON_Root_Balance_Info];
    
    return [self parseJSONBalanceInfoObject:jsonBalanceInfo];
}

#pragma mark - Helper Methods
+ (BalanceInfo *)parseJSONBalanceInfoObject:(NSDictionary *)jsonBalanceInfo
{
    BalanceInfo *balanceInfo = [[BalanceInfo alloc] init];
    
    if (jsonBalanceInfo[API_JSON_Last_Redeemded_Date] != nil) {
//        balanceInfo.lastRedeemedDate = jsonBalanceInfo[API_JSON_Last_Redeemded_Date];
    }
    if (jsonBalanceInfo[API_JSON_Balance_Info_Data_Points] != nil) {
        NSArray *jsonDataPoints = jsonBalanceInfo[API_JSON_Balance_Info_Data_Points];
        NSMutableArray *rewardDataPoints = [[NSMutableArray alloc] initWithCapacity:jsonDataPoints.count];

        for (NSDictionary *rewardDict in jsonDataPoints) {
            RewardDataPoint *dataPoint = [[RewardDataPoint alloc] init];
            dataPoint.offerId = [rewardDict[API_JSON_Balance_Info_Reward_Offer_Id] integerValue];
//            dataPoint.rewardedDate = rewardDict[API_JSON_Balance_Info_Reward_Date];
            dataPoint.rewardedValue = rewardDict[API_JSON_Balance_Info_Reward_Reward_Value];
        }
        
        balanceInfo.rewardDataPoints = rewardDataPoints;
    }
    
    return balanceInfo;
}

@end
