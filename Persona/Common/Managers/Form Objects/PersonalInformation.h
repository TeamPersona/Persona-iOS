//
//  PersonalInformation.h
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "ServerFormParameters.h"
#import "InformationSource.h"

@interface PersonalInformation : ServerFormParameters

+ (PersonalInformation *)parseDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSDate *creationTime;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *subCategory;
@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, strong) NSNumber *rewardValue;
@property (nonatomic, strong) NSArray *sources;

@end
