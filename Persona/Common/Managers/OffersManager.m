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

static const NSString *API_JSON_Partner_Id =            @"partnerId";
static const NSString *API_JSON_Partner_Name =          @"partnerName";
static const NSString *API_JSON_Partner_ImageURL =      @"partnerImageURL";
static const NSString *API_JSON_Offer_Id =              @"offerId";
static const NSString *API_JSON_Offer_Details =         @"offerDetails";
static const NSString *API_JSON_Category_Filters =      @"categoryFilters";
static const NSString *API_JSON_Category_Requested =    @"categoryRequested";
static const NSString *API_JSON_Category =              @"category";
static const NSString *API_JSON_Expiration_Date =       @"expirationDate";
static const NSString *API_JSON_Reward_Value =          @"rewardValue";
static const NSString *API_JSON_Current_Participants =  @"currNumParticipants";
static const NSString *API_JSON_Max_Participants =      @"maxParticipants";
static const NSString *API_JSON_Does_Match_Filters =    @"doesMatchFilters";

static const NSString *API_JSON_Category_Metadata_Name =        @"category";
static const NSString *API_JSON_Category_Metadata_Is_Missing =  @"isMissing";

typedef NS_ENUM(NSUInteger, OffersJSONType) {
    OffersJSONTypeFeatured,
    OffersJSONTypeProfile
};


@implementation OffersManager

+ (NSArray *)parseFeaturedOffersFromJSONFile:(NSString *)fileLocation
{
    return [self parseOffersFromJSONFile:fileLocation type:OffersJSONTypeFeatured];
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
    if (offerType == OffersJSONTypeFeatured) {
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

#pragma mark - Helper Methods
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
        partner.partnerImageURL = jsonOffer[API_JSON_Partner_ImageURL];
    }
    if (jsonOffer[API_JSON_Offer_Id] != nil) {
        offer.offerId = [jsonOffer[API_JSON_Offer_Id] integerValue];
    }
    if (jsonOffer[API_JSON_Offer_Details] != nil) {
        offer.offerDescription = jsonOffer[API_JSON_Offer_Details];
    }
    if (jsonOffer[API_JSON_Category_Filters] != nil) {
        offer.categoryFilterList = [self parseCategoryWithMetadata:jsonOffer[API_JSON_Category_Filters]];
    }
    if (jsonOffer[API_JSON_Category_Requested] != nil) {
        offer.categoryRequestedList = [self parseCategoryWithMetadata:jsonOffer[API_JSON_Category_Requested]];
    }
    if (jsonOffer[API_JSON_Category] != nil) {
        offer.categoryList = jsonOffer[API_JSON_Category];
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
    if (jsonOffer[API_JSON_Does_Match_Filters] != nil) {
        offer.doesMatchFilter = [jsonOffer[API_JSON_Does_Match_Filters] boolValue];
    }
    
    if (partner.name != nil && partner.userId) {
        offer.partner = partner;
    }
    
    return offer;
}

+ (NSDictionary *)parseCategoryWithMetadata:(NSArray *)categoryList
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:categoryList.count];
    for (NSDictionary *categoryMetadata in categoryList) {
        [dict setObject:categoryMetadata[API_JSON_Category_Metadata_Is_Missing] forKey:categoryMetadata[API_JSON_Category_Metadata_Name]];
    }
    return dict;
}

@end
