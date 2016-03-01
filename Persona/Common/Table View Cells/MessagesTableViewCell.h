//
//  MessagesTableViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-03-01.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *MessagesTableViewCellIdentifier = @"message";

@interface MessagesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notificationHorizontalSpacingLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notificationWidthLC;

- (void)setNotificationState:(BOOL)didRead;

@end
