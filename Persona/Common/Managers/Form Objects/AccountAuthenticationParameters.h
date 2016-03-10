//
//  AccountAuthenticationParameters.h
//  Persona
//
//  Created by Denny Kim on 2016-03-10.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "ServerFormParameters.h"

@interface AccountAuthenticationParameters : ServerFormParameters

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *grantType;

@end
