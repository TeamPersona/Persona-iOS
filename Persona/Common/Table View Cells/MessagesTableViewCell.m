//
//  MessagesTableViewCell.m
//  Persona
//
//  Created by Denny Kim on 2016-03-01.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "MessagesTableViewCell.h"
#import "ImageManager.h"

@implementation MessagesTableViewCell

- (void)awakeFromNib
{
    [[ImageManager sharedManager] getImageName:@"NotificationUnread" iconSize:CGSizeMake(16, 16) completion:^(UIImage *image) {
        self.notificationImageView.image = image;
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNotificationState:(BOOL)didRead
{
    if (didRead) {
        self.notificationHorizontalSpacingLC.constant = 0.0;
        self.notificationWidthLC.constant = 0.0;
    } else {
        self.notificationHorizontalSpacingLC.constant = 4.0;
        self.notificationWidthLC.constant = 16.0;
    }
}

@end
