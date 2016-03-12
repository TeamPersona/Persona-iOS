//
//  InformationDetails.h
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, InformationDetailsType) {
    InformationDetailsTypeNull,
    InformationDetailsTypeGeneric,
    InformationDetailsTypeString,
    InformationDetailsTypeNumber,
    InformationDetailsTypeBoolean,
    InformationDetailsTypeDate,
    InformationDetailsTypeOptionSingle,
    InformationDetailsTypeOptionMultiple
};

@interface InformationDetails : NSObject

@property (nonatomic, strong) NSString *mainCategory;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) InformationDetailsType type;
@property (nonatomic) NSInteger points;
@property (nonatomic, strong) NSDictionary *value;
@property (nonatomic, strong) NSArray *options;

@property (nonatomic, readonly) BOOL hasValue;

- (NSDictionary *)serverFriendlyValues;

@end
