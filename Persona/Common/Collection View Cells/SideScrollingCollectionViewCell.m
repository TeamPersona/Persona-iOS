//
//  SideScrollingCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2016-01-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "SideScrollingCollectionViewCell.h"
#import "NSDate+EpochTime.h"
#import "DateFormatManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *MESSAGE_READ_IMAGE_NAME = @"EnvelopeRead";
static NSString *MESSAGE_UNREAD_IMAGE_NAME = @"EnvelopeUnread";

@implementation SideScrollingCollectionViewCell

- (void)awakeFromNib
{
    self.partnerImageView.layer.minificationFilter = kCAFilterTrilinear;
    self.messageImageView.layer.minificationFilter = kCAFilterTrilinear;
}

- (void)setOffer:(Offer *)offer
{
    [self.partnerImageView sd_setImageWithURL:offer.partner.partnerImageURL];
    self.partnerTitleLabel.text = offer.partner.name;
    
    self.earnedLabel.text = [NSString stringWithFormat:@"$%@ earned!", offer.rewardString];
    self.dateEarnedLabel.text = [[DateFormatManager sharedManager] formatToShortDateString:offer.expirationDate];
    
    if (offer.didReadMessage) {
        self.messageImageView.image = [UIImage imageNamed:MESSAGE_READ_IMAGE_NAME];
    } else {
        self.messageImageView.image = [UIImage imageNamed:MESSAGE_UNREAD_IMAGE_NAME];
    }
}

@end
