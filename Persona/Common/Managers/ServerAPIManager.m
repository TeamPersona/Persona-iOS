//
//  ServerAPIManager.m
//  Persona
//
//  Created by Denny Kim on 2016-03-09.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "ServerAPIManager.h"
#import "Constants.h"
#import "AccountManager.h"
#import <AFNetworking.h>

typedef void(^VerifyAccessTokenCompletionBlock)(NSError *error);

@interface ServerAPIManager ()

@property (nonatomic, strong) AFHTTPSessionManager *accountSessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *authorizedSessionManager;
@property (nonatomic, strong) NSString *serverHostName;

@end

@implementation ServerAPIManager

+ (id)sharedManager
{
    static ServerAPIManager *manager;
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
        self.accountSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
#if DEBUG
        self.serverHostName = @"http://localhost:9000";
#else
        self.serverHostName = @"";
#endif
    }
    return self;
}

#pragma mark - Private Helper Methods
- (void)initializeAuthorizationSessionManager
{
    AccountManager *accountManager = [AccountManager sharedManager];
    self.authorizedSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSString *authorizationValue = [NSString stringWithFormat:@"%@ %@", [accountManager tokenType], [accountManager accessToken]];
    [self.authorizedSessionManager.requestSerializer setValue:authorizationValue forHTTPHeaderField:@"Authorization"];
}

- (void)verifyAccessToken:(VerifyAccessTokenCompletionBlock)completion
{
    if ([[AccountManager sharedManager] isAccessTokenExpired]) {
        [self accountRefreshAccessToken:[[AccountManager sharedManager] refreshToken] completionBlock:^(BOOL success, id response, NSError *error) {
            if (success) {
                [[AccountManager sharedManager] saveAccountInformation:response];
                if (!self.authorizedSessionManager) {
                    [self initializeAuthorizationSessionManager];
                }
                completion(nil);
            } else {
                completion(error);
            }
        }];
    }
    if (!self.authorizedSessionManager) {
        [self initializeAuthorizationSessionManager];
    }
    completion(nil);
}

#pragma mark - Account Creation and Authentication
- (void)accountCreatePersonaAccount:(PersonaAccountParameters *)account completionBlock:(ResponseCompletionBlock)completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@/account", self.serverHostName];
    
    [self.accountSessionManager POST:urlString parameters:[account formParameters] progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[AccountManager sharedManager] saveAccountInformation:[AccountInformation parseDictionary:responseObject]];
        completion(YES, nil, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(NO, nil, error);
    }];
}

- (void)accountAuthenticate:(AccountAuthenticationParameters *)authenticate completionBlock:(ResponseCompletionBlock)completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@/authenticate", self.serverHostName];
    
    [self.accountSessionManager POST:urlString parameters:[authenticate formParameters] progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[AccountManager sharedManager] saveAccountInformation:[AccountInformation parseDictionary:responseObject]];
        completion(YES, nil, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(NO, nil, error);
    }];
}

- (void)accountRefreshAccessToken:(NSString *)refreshToken completionBlock:(ResponseCompletionBlock)completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@/authorize", self.serverHostName];
    
    NSDictionary *params = @{@"client_id" : PersonaClientId,
                             @"grant_type" : @"refresh_token",
                             @"refresh_token" : refreshToken};
    [self.accountSessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(YES, [AccountInformation parseDictionary:responseObject], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(NO, nil, error);
    }];
}

#pragma mark - Account Querying
- (void)accountGetAccountInformation:(ResponseCompletionBlock)completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@/account", self.serverHostName];
    
    [self verifyAccessToken:^(NSError *error) {
        if (!error) {
            [self.authorizedSessionManager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                completion(YES, responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                completion(NO, nil, error);
            }];
        } else {
            NSLog(@"%@", error);
        }
    }];
}


@end