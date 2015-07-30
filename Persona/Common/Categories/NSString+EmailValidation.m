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
    if (self.length == 0) {
        return false;
    }
    
    // Check for whitespace
    NSRange whiteSpaceRange = [self rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (whiteSpaceRange.location != NSNotFound) {
        return false;
    }
    
    // Check for @ separator
    NSArray *emailComponents = [self componentsSeparatedByString:@"@"];
    
    if (emailComponents.count != 2) {
        return false;
    }
    
    // Check local component
    NSString *localString = [emailComponents[0] stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if (localString.length == 0) {
        return false;
    }
    
    NSString *localRegex = @"^.*";
    NSPredicate *localTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", localRegex];
    
    if (![localTest evaluateWithObject:localString]) {
        return false;
    }
    
    // Check domain component
    NSString *domainString = emailComponents[1];
    
    if (domainString.length == 0) {
        return false;
    }
    
    NSString *domainRegex = @"([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSPredicate *domainTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", domainRegex];

    if (![domainTest evaluateWithObject:domainString]) {
        return false;
    }
    
    return true;
}

@end
