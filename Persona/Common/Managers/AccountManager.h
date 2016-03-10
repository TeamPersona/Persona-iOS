//
//  AccountManager.h
//  Persona
//
//  Created by Denny Kim on 2016-03-10.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInformation.h"

@interface AccountManager : NSObject

+ (id)sharedManager;

- (void)saveAccountInformation:(AccountInformation *)info;
- (void)clearAccountInformation;

@property (nonatomic, readonly) BOOL isLoggedIn;
@property (nonatomic, readonly) BOOL isAccessTokenExpired;
@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSString *refreshToken;
@property (nonatomic, readonly) NSString *tokenType;

@end
