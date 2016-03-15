//
//  DateFormatManager.m
//  Persona
//
//  Created by Denny Kim on 2016-02-16.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "DateFormatManager.h"

static NSDateFormatter *sShortDateFormatter = nil;
static NSDateFormatter *sTimestampDateFormatter = nil;

@implementation DateFormatManager

+ (id)sharedManager
{
    static DateFormatManager *manager;
    static dispatch_once_t initManager;
    dispatch_once(&initManager, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        sShortDateFormatter = [[NSDateFormatter alloc] init];
        sShortDateFormatter.dateFormat = @"MMM/dd/YY";
        
        sTimestampDateFormatter = [[NSDateFormatter alloc] init];
        sTimestampDateFormatter.dateStyle = NSDateFormatterShortStyle;
        sTimestampDateFormatter.timeStyle = NSDateFormatterShortStyle;
        sTimestampDateFormatter.doesRelativeDateFormatting = YES;
    }
    return self;
}

- (NSString *)formatToShortDateString:(NSDate *)date
{
    return [sShortDateFormatter stringFromDate:date];
}

- (NSString *)formatToTimestampString:(NSDate *)date
{
    return [sTimestampDateFormatter stringFromDate:date];
}

@end
