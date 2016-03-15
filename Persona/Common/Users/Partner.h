//
//  Partner.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "User.h"

@interface Partner : User

+ (Partner *)parseDictionary:(NSDictionary *)dict;

@property (nonatomic, strong) NSString *partnerDescription;
@property (nonatomic, strong) NSURL *partnerWebsite;
@property (nonatomic, strong) NSURL *partnerImageURL;

@end
