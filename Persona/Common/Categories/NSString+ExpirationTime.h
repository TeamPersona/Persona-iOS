//
//  NSString+ExpirationTime.h
//  Persona
//
//  Created by Denny Kim on 2015-07-25.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *Expiration_Time_Less_Than_A_Minute = @"<1 min";
static NSString *Expiration_Time_Expired = @"Expired";

@interface NSString (ExpirationTime)

+ (NSString *)stringWithExpirationDate:(NSDate *)dateOfExpiration currentDate:(NSDate *)currentDate;

@end
