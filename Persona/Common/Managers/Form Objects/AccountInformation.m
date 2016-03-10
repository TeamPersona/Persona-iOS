//
//  AccountInformation.m
//  Persona
//
//  Created by Denny Kim on 2016-03-10.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "AccountInformation.h"

@implementation AccountInformation

+ (AccountInformation *)parseDictionary:(NSDictionary *)dict
{
    AccountInformation *info = [AccountInformation new];
    info.accessToken = dict[@"access_token"];
    // When a new access token is retrieved through a refresh token, the response will not include a new refresh token. Thus, omit the refresh token when parsing the response dictionary for that case.
    if (dict[@"refresh_token"] != nil) {
        info.refreshToken = dict[@"refresh_token"];
    }
    [info updateExpirationDate:dict[@"expires_in"]];
    info.tokenType = dict[@"token_type"];
    return info;
}

- (void)updateExpirationDate:(NSNumber *)expirationTime
{
    self.expirationDate = [[NSDate new] dateByAddingTimeInterval:[expirationTime doubleValue]];
}

@end
