//
//  PersonalInformation.m
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "PersonalInformation.h"
#import "NSString+CamelCase.h"

@implementation PersonalInformation

+ (PersonalInformation *)parseDictionary:(NSDictionary *)dictionary
{
    PersonalInformation *info = [PersonalInformation new];
    if (dictionary[@"creationTime"] != nil) {
        info.creationTime = dictionary[@"creationTime"];
    }
    info.category = dictionary[@"category"];
    info.subCategory = dictionary[@"subcategory"];
    info.rewardValue = @20;

    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    for (NSString *key in [dictionary[@"data"] allKeys]) {
        if ([key isEqualToString:@"source"]) {
            NSMutableArray *sources = [[NSMutableArray alloc] init];
            for (NSDictionary *source in dictionary[@"data"][key]) {
                [sources addObject:[InformationSource parseDictionary:source]];
            }
            info.sources = sources;
        } else {
            dataDict[key] = dictionary[@"data"][key];
        }
    }
    
    info.data = dataDict;
    return info;
}

- (NSDictionary *)formParameters
{
    return @{@"category" : self.category,
             @"subcategory" : self.subCategory,
             @"data" : self.data};
}

@end
