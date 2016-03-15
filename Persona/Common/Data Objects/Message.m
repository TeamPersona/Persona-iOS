//
//  Message.m
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "Message.h"
#import "MessageDetail.h"
#import "NSDate+EpochTime.h"

@implementation Message

+ (Message *)parseDictionary:(NSDictionary *)dict
{
    Message *msg = [[Message alloc] init];
    msg.offerId = [dict[@"offerId"] integerValue];
    msg.lastMessage = dict[@"msg"];
    msg.timestamp = [NSDate dateWithEpochTime:dict[@"timestamp"]];
    msg.partner = [Partner parseDictionary:dict];
    msg.didRead = NO;

    MessageDetail *detail = [[MessageDetail alloc] init];
    detail.text = msg.lastMessage;
    detail.isUsersMessage = NO;
    detail.timestamp = msg.timestamp;
    detail.type = MessageDetailTypeText;
    
    msg.messageDetails = [[NSMutableArray alloc] initWithObjects:detail, nil];
    return msg;
}

@end
