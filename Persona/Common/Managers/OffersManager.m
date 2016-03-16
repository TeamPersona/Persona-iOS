//
//  OffersManager.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "OffersManager.h"
#import "NSDate+EpochTime.h"

static const NSString *API_JSON_Root_Offers =           @"offers";
static const NSString *API_JSON_Root_Profile_Offers =   @"profileOffers";

static const NSString *API_JSON_Partner_Id =            @"partnerID";
static const NSString *API_JSON_Partner_Name =          @"partnerName";
static const NSString *API_JSON_Partner_ImageURL =      @"partnerImageUrl";
static const NSString *API_JSON_Offer_Id =              @"offerID";
static const NSString *API_JSON_Offer_Details =         @"offerDetails";
static const NSString *API_JSON_Info_Filters =          @"offerFilters";
static const NSString *API_JSON_Info_Required =         @"offerInfoRequired";
static const NSString *API_JSON_Category =              @"category";
static const NSString *API_JSON_Start_Date =            @"offerStartDate";
static const NSString *API_JSON_Expiration_Date =       @"offerExpirationDate";
static const NSString *API_JSON_Reward_Value =          @"offerReward";
static const NSString *API_JSON_Current_Participants =  @"offerCurrentParticipants";
static const NSString *API_JSON_Max_Participants =      @"offerMaxParticipants";
static const NSString *API_JSON_Does_Match_Filters =    @"doesMatchFilters";
static const NSString *API_JSON_Min_Reward_Tier =       @"offerMinRank";

static const NSString *API_JSON_Category_Metadata_Name =        @"informationType";
static const NSString *API_JSON_Category_Metadata_Is_Missing =  @"informationMissing";

typedef NS_ENUM(NSUInteger, OffersJSONType) {
    OffersJSONTypeHome,
    OffersJSONTypeProfile
};


@implementation OffersManager

+ (NSArray *)parseOffersFromJSONFile:(NSString *)fileLocation
{
    return [self parseOffersFromJSONFile:fileLocation type:OffersJSONTypeHome];
}

+ (NSArray *)parseProfileOffersFromJSONFile:(NSString *)fileLocation
{
    return [self parseOffersFromJSONFile:fileLocation type:OffersJSONTypeProfile];
}

+ (NSArray *)parseOffersFromJSONFile:(NSString *)fileLocation type:(OffersJSONType)offerType
{
    NSDictionary *json = [super getJSONDataFromFile:fileLocation];
    
    if (json == nil) {
        return @[];
    }
    
    NSDictionary *jsonOffers;
    if (offerType == OffersJSONTypeHome) {
        jsonOffers = json[API_JSON_Root_Offers];
    } else if (offerType == OffersJSONTypeProfile) {
        jsonOffers = json[API_JSON_Root_Profile_Offers];
    }
    
    NSMutableArray *offers = [[NSMutableArray alloc] initWithCapacity:jsonOffers.count];
    for (NSDictionary *offer in jsonOffers) {
        [offers addObject:[self parseJSONOfferObject:offer]];
    }
    return offers;
}

+ (NSArray *)sortOffers:(NSArray *)offers bySortType:(OfferSortType)sortType
{
    return nil;
}

+ (Offer *)parseJSONOfferObject:(NSDictionary *)jsonOffer
{
    Offer *offer = [[Offer alloc] init];
    Partner *partner = [[Partner alloc] init];
    
    if (jsonOffer[API_JSON_Partner_Id] != nil) {
        partner.userId = [jsonOffer[API_JSON_Partner_Id] integerValue];
    }
    if (jsonOffer[API_JSON_Partner_Name] != nil) {
        partner.name = jsonOffer[API_JSON_Partner_Name];
    }
    if (jsonOffer[API_JSON_Partner_ImageURL] != nil) {
        partner.partnerImageURL = [NSURL URLWithString:jsonOffer[API_JSON_Partner_ImageURL]];
    }
    if (jsonOffer[API_JSON_Offer_Id] != nil) {
        offer.offerId = [jsonOffer[API_JSON_Offer_Id] integerValue];
    }
    if (jsonOffer[API_JSON_Offer_Details] != nil) {
        offer.offerDescription = jsonOffer[API_JSON_Offer_Details];
    }
    if (jsonOffer[API_JSON_Info_Filters] != nil) {
        NSDictionary *infos = jsonOffer[API_JSON_Info_Filters];
        offer.filterCategoriesList = infos.allKeys;
        offer.infoFilterList = [self parseOfferInfosWithMetadata:infos];
    }
    if (jsonOffer[API_JSON_Info_Required] != nil) {
        NSDictionary *infos = jsonOffer[API_JSON_Info_Required];
        offer.requiredCategoriesList = infos.allKeys;
        offer.infoRequiredList = [self parseOfferInfosWithMetadata:infos];
    }
    if (jsonOffer[API_JSON_Start_Date] != nil) {
        offer.startDate = [NSDate dateWithEpochTime:jsonOffer[API_JSON_Start_Date]];
    }
    if (jsonOffer[API_JSON_Expiration_Date] != nil) {
        offer.expirationDate = [NSDate dateWithEpochTime:jsonOffer[API_JSON_Expiration_Date]];
    }
    if (jsonOffer[API_JSON_Reward_Value] != nil) {
        offer.rewardValue = jsonOffer[API_JSON_Reward_Value];
    }
    if (jsonOffer[API_JSON_Current_Participants] != nil) {
        offer.currentParticipants = [jsonOffer[API_JSON_Current_Participants] integerValue];
    }
    if (jsonOffer[API_JSON_Max_Participants] != nil) {
        offer.totalParticipants = [jsonOffer[API_JSON_Max_Participants] integerValue];
    }
    if (jsonOffer[API_JSON_Min_Reward_Tier] != nil) {
        offer.minRewardTier = [jsonOffer[API_JSON_Min_Reward_Tier] integerValue];
    }
    
    if (partner.name != nil && partner.userId) {
        offer.partner = partner;
    }
    
    return offer;
}

#pragma mark - Helper Methods
+ (NSArray *)parseOfferInfosWithMetadata:(NSDictionary *)offerInfos
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSArray *infos in offerInfos.allValues) {
        for (NSDictionary *info in infos) {
            NSMutableDictionary *listObj = [[NSMutableDictionary alloc] initWithCapacity:2];
            listObj[API_JSON_Category_Metadata_Name] = info[API_JSON_Category_Metadata_Name];
            if ([info[API_JSON_Category_Metadata_Is_Missing] isKindOfClass:[NSString class]]) {
                if ([info[API_JSON_Category_Metadata_Is_Missing] isEqualToString:@"true"]) {
                    listObj[API_JSON_Category_Metadata_Is_Missing] = @true;
                } else {
                    listObj[API_JSON_Category_Metadata_Is_Missing] = @false;
                }
            } else {
                listObj[API_JSON_Category_Metadata_Is_Missing] = info[API_JSON_Category_Metadata_Is_Missing];
            }
            [result addObject:listObj];
        }
    }
    return result;
}

@end
