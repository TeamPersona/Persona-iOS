//
//  AccountInformation.h
//  Persona
//
//  Created by Denny Kim on 2016-03-10.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInformation : NSObject

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSDate *expirationDate;
@property (nonatomic, strong) NSString *tokenType;

+ (AccountInformation *)parseDictionary:(NSDictionary *)dict;
- (void)updateExpirationDate:(NSNumber *)expirationTime;

@end
