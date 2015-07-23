//
//  PointsManager.h
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PointsDataSortType) {
    PointsDataSortTypePointsAscending,
    PointsDataSortTypePointsDescending,
    PointsDataSortTypeCompleted,
    PointsDataSortTypeTier
};

@interface PointsManager : NSObject

+ (NSArray *)parsePointsDataFromJSONFile:(NSString *)fileLocation;
+ (NSArray *)sortPointsData:(NSArray *)pointsData bySortType:(PointsDataSortType)sortType;

@end
