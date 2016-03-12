//
//  ProfileInformationManager.m
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "ProfileInformationManager.h"

static const NSString *API_JSON_INFO_CATEGORY_NAME = @"categoryName";
static const NSString *API_JSON_INFO_CATEGORY_INFO = @"info";
static const NSString *API_JSON_INFO_CATEGORY_COMPLETION_POINTS = @"completionPoints";

static const NSString *API_JSON_INFO_CATEGORY_DETAILS_NAME = @"name";
static const NSString *API_JSON_INFO_CATEGORY_DETAILS_TYPE = @"type";
static const NSString *API_JSON_INFO_CATEGORY_DETAILS_POINTS = @"points";
static const NSString *API_JSON_INFO_CATEGORY_DETAILS_VALUE = @"value";
static const NSString *API_JSON_INFO_CATEGORY_DETAILS_OPTIONS = @"options";
static const NSString *API_JSON_INFO_CATEGORY_DETAILS_OPTION_TYPE = @"optionType";

@implementation ProfileInformationManager

+ (InformationCategory *)parseProfileInformationCategory:(NSString *)fileLocation
{
    NSDictionary *json = [super getJSONDataFromFile:fileLocation];
    
    if (json == nil) {
        return nil;
    }
    
    InformationCategory *infoCategory = [[InformationCategory alloc] init];
    if (json[API_JSON_INFO_CATEGORY_NAME] != nil) {
        infoCategory.categoryName = json[API_JSON_INFO_CATEGORY_NAME];
    }
    if (json[API_JSON_INFO_CATEGORY_COMPLETION_POINTS] != nil) {
        infoCategory.completionPoints = [json[API_JSON_INFO_CATEGORY_COMPLETION_POINTS] integerValue];
    }
    if (json[API_JSON_INFO_CATEGORY_INFO] != nil) {
        NSMutableArray *details = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in json[API_JSON_INFO_CATEGORY_INFO]) {
            InformationDetails *infoDetail = [self parseProfileInformationDetails:dict];
            infoDetail.mainCategory = infoCategory.categoryName;
            [details addObject:infoDetail];
        }
        infoCategory.informationDetails = details;
    }
    return infoCategory;
}

+ (InformationDetails *)parseProfileInformationDetails:(NSDictionary *)details
{
    InformationDetails *infoDetails = [[InformationDetails alloc] init];
    if (details[API_JSON_INFO_CATEGORY_DETAILS_NAME] != nil) {
        infoDetails.name = details[API_JSON_INFO_CATEGORY_DETAILS_NAME];
    }
    if (details[API_JSON_INFO_CATEGORY_DETAILS_TYPE] != nil) {
        infoDetails.type = (InformationDetailsType)[details[API_JSON_INFO_CATEGORY_DETAILS_TYPE] integerValue];
    }
    if (details[API_JSON_INFO_CATEGORY_DETAILS_POINTS] != nil) {
        infoDetails.points = [details[API_JSON_INFO_CATEGORY_DETAILS_POINTS] integerValue];
    }
    if (details[API_JSON_INFO_CATEGORY_DETAILS_OPTIONS] != nil) {
        infoDetails.options = details[API_JSON_INFO_CATEGORY_DETAILS_OPTIONS];
    }
    if (details[API_JSON_INFO_CATEGORY_DETAILS_VALUE] != nil) {
        infoDetails.value = details[API_JSON_INFO_CATEGORY_DETAILS_VALUE];
    }
    return infoDetails;
}

@end
