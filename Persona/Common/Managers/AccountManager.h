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

- (BOOL)isLoggedIn;
- (NSString *)getAccessToken;

- (void)saveAccountInformation:(AccountInformation *)info;
- (void)clearAccountInformation;

@end
