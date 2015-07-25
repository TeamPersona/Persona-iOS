//
//  NSString+ExpirationTime.m
//  Persona
//
//  Created by Denny Kim on 2015-07-25.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "NSString+ExpirationTime.h"

static const NSInteger Seconds_Per_Minute = 60;
static const NSInteger Seconds_Per_Hour = 60 * Seconds_Per_Minute;
static const NSInteger Seconds_Per_Day = 24 * Seconds_Per_Hour;

@implementation NSString (ExpirationTime)

+ (NSString *)stringWithExpirationDate:(NSDate *)expirationDate
{
    NSDate *currentDate = [NSDate date];
    if ([expirationDate compare:currentDate] == NSOrderedDescending) {
        NSTimeInterval expirationTimeInterval = [expirationDate timeIntervalSinceDate:[NSDate date]];
        
        NSInteger ti = (NSInteger)expirationTimeInterval;
        
        NSInteger minutes = (ti / Seconds_Per_Minute) % Seconds_Per_Minute;
        NSInteger hours = (ti / Seconds_Per_Hour) % Seconds_Per_Minute;
        NSInteger days = (ti / Seconds_Per_Day) % Seconds_Per_Minute;
        
        if (days > 0) {
            NSString *dayStr = [NSString stringWithFormat:@"<%li day", days];
            if (days > 1) {
                dayStr = [dayStr stringByAppendingString:@"s"];
            }
            return dayStr;
        } else if (hours > 0) {
            NSString *hourStr = [NSString stringWithFormat:@"<%li hour", hours];
            if (hours > 1) {
                hourStr = [hourStr stringByAppendingString:@"s"];
            }
            
            return hourStr;
        } else if (minutes > 0) {
                NSString *minString = [NSString stringWithFormat:@"<%li min", minutes];
                if (minutes > 1) {
                    [minString stringByAppendingString:@"s"];
                }
                
                return minString;
        } else {
            return Expiration_Time_Less_Than_A_Minute;
        }
    } else {
        return Expiration_Time_Expired;
    }
}

@end
