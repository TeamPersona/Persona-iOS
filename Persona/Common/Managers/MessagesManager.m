//
//  MessagesManager.m
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "MessagesManager.h"
#import "ServerAPIManager.h"

@implementation MessagesManager

+ (id)sharedManager
{
    static MessagesManager *manager;
    static dispatch_once_t initManager;
    dispatch_once(&initManager, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)updateMessages
{
    [[ServerAPIManager sharedManager] chatGetMessages:^(BOOL success, id response, NSError *error) {
        if (success) {
            self.allMessages = response;
            [self broadcastUpdatedMessagesNotification];
        } else {
            NSLog(@"MessagesManager: ERROR getting all messages: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - Helper Methods
- (void)broadcastUpdatedMessagesNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MessagesNotificationUpdatedMessages object:nil];
}

@end
