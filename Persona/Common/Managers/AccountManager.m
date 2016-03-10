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
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.account = [AccountInformation new];
        self.account.accessToken = [userDefaults objectForKey:PersonaAccountManagerAccessTokenKey];
        self.account.refreshToken = [userDefaults objectForKey:PersonaAccountManagerRefreshTokenKey];
        self.account.expirationDate = [userDefaults objectForKey:PersonaAccountManagerExpirationDateKey];
    }
    return self;
}

- (NSString *)getAccessToken
{
    // If the current date is later than the expiration date, we need to refresh the access token.
    if ([[NSDate new] compare:self.account.expirationDate] == NSOrderedDescending) {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        __block BOOL complete = NO;
        __block NSString *accessToken;
        __block NSNumber *expirationTime;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [[ServerAPIManager sharedManager] accountRefreshToken:@"" completionBlock:^(BOOL success, NSDictionary *response, NSError *error) {
                if (success) {
                    accessToken = response[@"access_token"];
                    expirationTime = response[@"expires_in"];
                } else {
                    NSLog(@"%@", error);
                }
                complete = YES;
                dispatch_semaphore_signal(semaphore);
            }];
        });
        
        while (!complete) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        self.account.accessToken = accessToken;
        [self.account updateExpirationDate:expirationTime];
    }
    return self.account.accessToken;
}

- (BOOL)isLoggedIn
{
    return self.account.accessToken != nil;
}

- (void)saveAccountInformation:(AccountInformation *)info
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:info.accessToken forKey:PersonaAccountManagerAccessTokenKey];
    [userDefaults setObject:info.refreshToken forKey:PersonaAccountManagerRefreshTokenKey];
    [userDefaults setObject:info.expirationDate forKey:PersonaAccountManagerExpirationDateKey];
    [userDefaults synchronize];
}

- (void)clearAccountInformation
{
    self.account.accessToken = nil;
    self.account.refreshToken = nil;
    self.account.expirationDate = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:PersonaAccountManagerAccessTokenKey];
    [userDefaults removeObjectForKey:PersonaAccountManagerRefreshTokenKey];
    [userDefaults removeObjectForKey:PersonaAccountManagerExpirationDateKey];
    [userDefaults synchronize];
}

@end
