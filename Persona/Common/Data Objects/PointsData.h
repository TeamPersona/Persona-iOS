//
//  PointsData.h
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PointsDataType) {
    PointsDataTypeBasicPublic,
    PointsDataTypeBasicPrivate,
    PointsDataTypeSocialMedia,
    PointsDataTypeFinancial,
    PointsDataTypeHealth
};

@interface PointsData : NSObject

@property (nonatomic, strong) NSString *dataTitle;
@property (nonatomic) PointsDataType dataType;
@property (nonatomic) NSInteger dataPointsValue;
@property (nonatomic) BOOL isDataProvided;
@property (nonatomic, strong) NSURL *dataImageURL;

@end
