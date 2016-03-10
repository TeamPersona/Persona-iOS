//
//  AccountManager.m
//  Persona
//
//  Created by Denny Kim on 2016-03-10.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "AccountManager.h"
#import "ServerAPIManager.h"

static NSString *PersonaAccountManagerAccessTokenKey = @"com.uwpib.persona.accessToken";
static NSString *PersonaAccountManagerRefreshTokenKey = @"com.uwpib.persona.refreshToken";
static NSString *PersonaAccountManagerExpirationDateKey = @"com.uwpib.persona.expirationDate";
static NSString *PersonaAccountManagerTokenTypeKey = @"com.uwpib.persona.tokenType";

@interface AccountManager ()

@property (nonatomic, strong) AccountInformation *account;

@end

@implementation AccountManager

+ (id)sharedManager
{
    static AccountManager *manager;
    static dispatch_once_t initManager;
    dispatch_once(&initManager, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.account = [AccountInformation new];
        [self retrieveAccountInformation];
    }
    return self;
}

- (BOOL)isAccessTokenExpired
{
    // If the current date is later than the expiration date, the access token has expired.
    return [[NSDate new] compare:self.account.expirationDate] == NSOrderedDescending;
}

- (BOOL)isLoggedIn
{
    return self.account.accessToken != nil;
}

- (NSString *)accessToken
{
    return self.account.accessToken;
}

- (NSString *)refreshToken
{
    return self.account.refreshToken;
}

- (NSString *)tokenType
{
    return self.account.tokenType;
}

- (void)retrieveAccountInformation
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.account.accessToken = [userDefaults objectForKey:PersonaAccountManagerAccessTokenKey];
    self.account.refreshToken = [userDefaults objectForKey:PersonaAccountManagerRefreshTokenKey];
    self.account.expirationDate = [userDefaults objectForKey:PersonaAccountManagerExpirationDateKey];
    self.account.tokenType = [userDefaults objectForKey:PersonaAccountManagerTokenTypeKey];
}

- (void)saveAccountInformation:(AccountInformation *)info
{
    self.account.accessToken = info.accessToken;
    if (info.refreshToken) {
        self.account.refreshToken = info.refreshToken;
    }
    self.account.expirationDate = info.expirationDate;
    self.account.tokenType = info.tokenType;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:info.accessToken forKey:PersonaAccountManagerAccessTokenKey];
    [userDefaults setObject:info.expirationDate forKey:PersonaAccountManagerExpirationDateKey];
    [userDefaults setObject:info.tokenType forKey:PersonaAccountManagerTokenTypeKey];

    if (info.refreshToken) {
        [userDefaults setObject:info.refreshToken forKey:PersonaAccountManagerRefreshTokenKey];
    }
    
    [userDefaults synchronize];
}

- (void)clearAccountInformation
{
    self.account.accessToken = nil;
    self.account.refreshToken = nil;
    self.account.expirationDate = nil;
    self.account.tokenType = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:PersonaAccountManagerAccessTokenKey];
    [userDefaults removeObjectForKey:PersonaAccountManagerRefreshTokenKey];
    [userDefaults removeObjectForKey:PersonaAccountManagerExpirationDateKey];
    [userDefaults removeObjectForKey:PersonaAccountManagerTokenTypeKey];
    [userDefaults synchronize];
}

@end
