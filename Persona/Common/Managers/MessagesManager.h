//
//  MessagesManager.h
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *MessagesNotificationUpdatedMessages = @"MessagesNotification_UpdatedMessages";

@interface MessagesManager : NSObject

+ (id)sharedManager;
- (void)updateMessages;

@property (nonatomic, strong) NSArray *allMessages;

@end
