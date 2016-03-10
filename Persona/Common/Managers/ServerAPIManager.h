//
//  ServerAPIManager.h
//  Persona
//
//  Created by Denny Kim on 2016-03-09.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonaAccountParameters.h"
#import "AccountAuthenticationParameters.h"

static NSString *ServerHostURL = @"http://localhost:9000";

typedef void(^ResponseCompletionBlock)(BOOL success, NSDictionary *response, NSError *error);

@interface ServerAPIManager : NSObject

+ (id)sharedManager;

// Account
- (void)accountCreatePersonaAccount:(PersonaAccountParameters *)account completionBlock:(ResponseCompletionBlock)completion;
- (void)accountAuthenticate:(AccountAuthenticationParameters *)authenticate completionBlock:(ResponseCompletionBlock)completion;
- (void)accountRefreshToken:(NSString *)refreshToken completionBlock:(ResponseCompletionBlock)completion;



@end
