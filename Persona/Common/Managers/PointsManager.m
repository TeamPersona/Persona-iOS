//
//  PointsManager.m
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "PointsManager.h"
#import "PointsData.h"

static const NSString *API_JSON_Root_Points = @"profilePoints";

static const NSString *API_JSON_Data_Source_Name =              @"dataSourceName";
static const NSString *API_JSON_Data_Source_Image_URL =         @"dataSourceImageURL";
static const NSString *API_JSON_Data_Source_Type =              @"dataSourceType";
static const NSString *API_JSON_Data_Source_Points_Value =      @"pointsValue";
static const NSString *API_JSON_Data_Source_Is_Data_Provided =  @"isDataProvided";

@implementation PointsManager

+ (NSArray *)parsePointsDataFromJSONFile:(NSString *)fileLocation
{
    NSDictionary *json = [super getJSONDataFromFile:fileLocation];
    
    if (json == nil) {
        return @[];
    }
    
    NSDictionary *jsonPointsData = json[API_JSON_Root_Points];
    NSMutableArray *pointsData = [[NSMutableArray alloc] initWithCapacity:jsonPointsData.count];
    for (NSDictionary *data in jsonPointsData) {
        [pointsData addObject:[self parseJSONPointsDataObject:data]];
    }
    return pointsData;
}

+ (NSArray *)sortPointsData:(NSArray *)pointsData bySortType:(PointsDataSortType)sortType
{
    return nil;
}

#pragma mark - Helper Methods
+ (PointsData *)parseJSONPointsDataObject:(NSDictionary *)jsonData
{
    PointsData *pointsData = [[PointsData alloc] init];
    if (jsonData[API_JSON_Data_Source_Name] != nil) {
        pointsData.dataTitle = jsonData[API_JSON_Data_Source_Name];
    }
    if (jsonData[API_JSON_Data_Source_Image_URL] != nil) {
        pointsData.dataImageURL = jsonData[API_JSON_Data_Source_Image_URL];
    }
    if (jsonData[API_JSON_Data_Source_Type] != nil) {
        pointsData.dataType = (PointsDataType)jsonData[API_JSON_Data_Source_Type];
    }
    if (jsonData[API_JSON_Data_Source_Points_Value] != nil) {
        pointsData.dataPointsValue = jsonData[API_JSON_Data_Source_Points_Value];
    }
    if (jsonData[API_JSON_Data_Source_Is_Data_Provided] != nil) {
        pointsData.isDataProvided = jsonData[API_JSON_Data_Source_Is_Data_Provided];
    }
    
    return pointsData;
}

@end
