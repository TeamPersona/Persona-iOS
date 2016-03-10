//
//  AccountAuthenticationParameters.m
//  Persona
//
//  Created by Denny Kim on 2016-03-10.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "AccountAuthenticationParameters.h"
#import "Constants.h"

@implementation AccountAuthenticationParameters

- (NSDictionary *)formParameters
{
    return @{@"client_id" : PersonaClientId,
             @"email" : self.email,
             @"password" : self.password,
             @"grant_type" : self.grantType};
}

@end
