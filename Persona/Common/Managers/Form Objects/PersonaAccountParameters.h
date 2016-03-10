//
//  PersonaAccountParameters.h
//  Persona
//
//  Created by Denny Kim on 2016-03-09.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerFormParameters.h"

@interface PersonaAccountParameters : ServerFormParameters

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phoneNumber;

@end
