//
//  Partner.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "Partner.h"

@implementation Partner

+ (Partner *)parseDictionary:(NSDictionary *)dict
{
    Partner *partner = [[Partner alloc] init];
    partner.name = dict[@"partnerName"];
    partner.userId = dict[@"partnerID"] ? [dict[@"partnerID"] integerValue] : 0;
    partner.partnerDescription = dict[@"partnerDescription"];
    partner.partnerImageURL = dict[@"partnerImageUrl"] ? [NSURL URLWithString:dict[@"partnerImageUrl"]] : nil;
    partner.partnerWebsite = dict[@"partnerWebsite"] ? [NSURL URLWithString:dict[@"partnerWebsite"]] : nil;
    return partner;
}

@end
