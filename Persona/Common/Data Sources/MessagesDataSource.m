//
//  MessagesDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-03-01.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "MessagesDataSource.h"
#import "MessagesTableViewCell.h"
#import "Message.h"
#import "ImageManager.h"
#import "DateFormatManager.h"

@interface MessagesDataSource ()

@property (nonatomic, strong) NSArray *messages;

@end

@implementation MessagesDataSource

- (id)initWithMessages:(NSArray *)messages
{
    self = [super init];
    if (self) {
        self.messages = messages;
    }
    return self;
}

- (void)updateWithMessages:(NSArray *)messages
{
    self.messages = messages;
}

#pragma mark - UITableView DataSource Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessagesTableViewCellIdentifier forIndexPath:indexPath];
    
    Message *message = self.messages[indexPath.row];
    
    cell.messageImageView.image = nil;

    [[ImageManager sharedManager] getWebImage:message.partner.partnerImageURL iconSize:MessageImageViewSize completion:^(UIImage *image) {
        cell.messageImageView.image = image;
    }];
    
    cell.nameLabel.text = message.partner.name;
    cell.messageLabel.text = message.lastMessage;
    cell.dateLabel.text = [[DateFormatManager sharedManager] formatToTimestampString:message.timestamp];
    [cell setNotificationState:message.didRead];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

@end
