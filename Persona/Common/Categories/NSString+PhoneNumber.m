//
//  NSString+PhoneNumber.m
//  Persona
//
//  Created by Denny Kim on 2015-07-16.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "NSString+PhoneNumber.h"

@implementation NSString (PhoneNumber)

- (BOOL)isValidPhoneNumber
{
    //TODO: use a better validation technique
    return self.length == 10;
}

- (NSString *)formatStringToPhoneNumber
{
    //TODO
    return self;
}

@end
