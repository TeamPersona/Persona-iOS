//
//  InformationDetails.m
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationDetails.h"
#import "NSString+CamelCase.h"

@implementation InformationDetails

- (BOOL)hasValue
{
    return _value.count != 0;
}

- (NSDictionary *)serverFriendlyValues
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:self.value.count];
    for (NSString *key in self.value.allKeys) {
        dict[[key toCamelCase]] = self.value[key];
    }
    return dict;
}

@end
