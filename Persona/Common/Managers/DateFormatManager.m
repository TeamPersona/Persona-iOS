//
//  DateFormatManager.m
//  Persona
//
//  Created by Denny Kim on 2016-02-16.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "DateFormatManager.h"

static NSDateFormatter *sFormatter = nil;

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
        sFormatter = [[NSDateFormatter alloc] init];
        sFormatter.dateFormat = @"MMM/dd/YY";
    }
    return self;
}

- (NSString *)formatToShortDateString:(NSDate *)date
{
    return [sFormatter stringFromDate:date];
}

@end
