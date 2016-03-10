//
//  PersonaAccountParameters.m
//  Persona
//
//  Created by Denny Kim on 2016-03-09.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "PersonaAccountParameters.h"
#import "Constants.h"

@implementation PersonaAccountParameters

- (NSDictionary *)formParameters
{
    return @{@"client_id" : PersonaClientId,
             @"given_name" : self.firstName,
             @"family_name" : self.lastName,
             @"email" : self.email,
             @"phone_number" : self.phoneNumber,
             @"password" : self.password};
}

@end
