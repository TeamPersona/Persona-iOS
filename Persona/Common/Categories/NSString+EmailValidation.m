//
//  NSString+EmailValidation.m
//  Persona
//
//  Created by Denny Kim on 2015-07-15.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "NSString+EmailValidation.h"

@implementation NSString (EmailValidation)

- (BOOL)isValidEmail
{
    NSString *emailRegex = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
