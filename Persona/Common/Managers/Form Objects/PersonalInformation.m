//
//  PersonalInformation.m
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "PersonalInformation.h"

@implementation PersonalInformation

+ (PersonalInformation *)parseDictionary:(NSDictionary *)dictionary
{
    PersonalInformation *info = [PersonalInformation new];
    if (dictionary[@"creationTime"] != nil) {
        info.creationTime = dictionary[@"creationTime"];
    }
    info.category = dictionary[@"category"];
    info.subCategory = dictionary[@"subcategory"];
    info.data = dictionary[@"data"];
    return info;
}

- (NSDictionary *)formParameters
{
    return @{@"category" : self.category,
             @"subcategory" : self.subCategory,
             @"data" : self.data};
}

@end
