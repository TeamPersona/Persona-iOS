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
#import "AccountInformation.h"
#import "PersonalInformation.h"

static NSString *ServerHostURL = @"http://localhost:9000";

typedef void(^ResponseCompletionBlock)(BOOL success, id response, NSError *error);

@interface ServerAPIManager : NSObject

+ (id)sharedManager;

// Account Creation and Authentication
- (void)accountCreatePersonaAccount:(PersonaAccountParameters *)account completionBlock:(ResponseCompletionBlock)completion;
- (void)accountAuthenticate:(AccountAuthenticationParameters *)authenticate completionBlock:(ResponseCompletionBlock)completion;
- (void)accountRefreshAccessToken:(NSString *)refreshToken completionBlock:(ResponseCompletionBlock)completion;

// Account Querying
- (void)accountGetAccountInformation:(ResponseCompletionBlock)completion;

- (void)accountWithdrawal:(ResponseCompletionBlock)completion;
- (void)accountDeposit:(PersonalInformation *)info completion:(ResponseCompletionBlock)completion;

// Offers
- (void)offersGetOffer:(NSInteger)offerId completionBlock:(ResponseCompletionBlock)completion;
- (void)offersGetNextOffers:(NSInteger)lastOfferId completionBlock:(ResponseCompletionBlock)completion;

// Chat
- (void)chatGetMessages:(ResponseCompletionBlock)completion;

@end
