//
//  Message.h
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Partner.h"

@interface Message : NSObject

+ (Message *)parseDictionary:(NSDictionary *)dict;

@property (nonatomic) NSInteger offerId;
@property (nonatomic, strong) NSString *lastMessage;
@property (nonatomic, strong) NSArray *messageDetails;
@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) Partner *partner;
@property (nonatomic) BOOL didRead;

@end
