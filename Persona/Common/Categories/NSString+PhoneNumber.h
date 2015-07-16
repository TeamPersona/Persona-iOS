//
//  NSString+PhoneNumber.h
//  Persona
//
//  Created by Denny Kim on 2015-07-16.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PhoneNumber)

- (BOOL)isValidPhoneNumber;
- (NSString *)formatStringToPhoneNumber;

@end
