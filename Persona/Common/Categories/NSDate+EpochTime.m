//
//  NSDate+EpochTime.m
//  Persona
//
//  Created by Denny Kim on 2015-07-25.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "NSDate+EpochTime.h"

@implementation NSDate (EpochTime)

+ (NSDate *)dateWithEpochTime:(NSNumber *)epochTime
{
    return [NSDate dateWithTimeIntervalSince1970:[epochTime doubleValue]];
}

- (NSNumber *)epochTime
{
    return [NSNumber numberWithDouble:[self timeIntervalSince1970]];
}

@end
