//
//  NSDate+EpochTime.h
//  Persona
//
//  Created by Denny Kim on 2015-07-25.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (EpochTime)

+ (NSDate *)dateWithEpochTime:(NSNumber *)epochTime;

@end
