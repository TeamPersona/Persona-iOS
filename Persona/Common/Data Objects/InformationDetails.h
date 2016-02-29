//
//  InformationDetails.h
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, InformationDetailsType) {
    InformationDetailsTypeNull = 0,
    InformationDetailsTypeString = 1,
    InformationDetailsTypeNumber = 2,
    InformationDetailsTypeBoolean = 3,
    InformationDetailsTypeDate = 4,
    InformationDetailsTypeOptionSingle = 5,
    InformationDetailsTypeOptionMultiple = 6
};

@interface InformationDetails : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) InformationDetailsType type;
@property (nonatomic) NSInteger points;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) NSArray *options;

@property (nonatomic, readonly) BOOL hasValue;

@end
