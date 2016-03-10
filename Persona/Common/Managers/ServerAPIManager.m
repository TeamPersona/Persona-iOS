//
//  ServerAPIManager.m
//  Persona
//
//  Created by Denny Kim on 2016-03-09.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "ServerAPIManager.h"
#import "AccountManager.h"
#import <AFNetworking.h>

@interface ServerAPIManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
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
        NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:conf];
        
#if DEBUG
        self.serverHostName = @"http://localhost:9000";
#else
        self.serverHostName = @"";
#endif
    }
    return self;
}

#pragma mark - Account
- (void)accountCreatePersonaAccount:(PersonaAccountParameters *)account
{
    NSString *urlString = [NSString stringWithFormat:@"%@/account", self.serverHostName];
    
    [self.sessionManager POST:urlString parameters:[account formParameters] progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AccountInformation *info = [AccountInformation parseDictionary:responseObject];
        [[AccountManager sharedManager] saveAccountInformation:info];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)accountRefreshToken:(NSString *)refreshToken completionBlock:(ResponseCompletionBlock)completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@/authorize", self.serverHostName];
    
    [self.sessionManager POST:urlString parameters:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(YES, responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(NO, nil, error);
    }];
}

@end
