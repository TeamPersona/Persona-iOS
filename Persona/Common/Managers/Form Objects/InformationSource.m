//
//  InformationSource.m
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationSource.h"
#import "NSDate+EpochTime.h"

@implementation InformationSource

+ (InformationSource *)parseDictionary:(NSDictionary *)dictionary
{
    InformationSource *source = [InformationSource new];
    source.name = dictionary[@"sourceName"];
    source.dateAdded = [NSDate dateWithEpochTime:dictionary[@"dateAdded"]];
    return source;
}

- (NSDictionary *)formDictionary
{
    return @{@"sourceName": self.name,
             @"dateAdded" : [self.dateAdded epochTime]};
}

@end
