//
//  OfferTableViewself.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "OfferTableViewCell.h"
#import "NSString+ExpirationTime.h"
#import "UIColor+ProjectColors.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation OfferTableViewCell

- (void)awakeFromNib
{
    self.partnerImageView.layer.minificationFilter = kCAFilterTrilinear;
    self.expirationImageView.layer.minificationFilter = kCAFilterTrilinear;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)populateOfferInfo:(Offer *)offer
{
    self.titleLabel.text = offer.partner.name;
    [self.partnerImageView sd_setImageWithURL:offer.partner.partnerImageURL];
    self.categoryLabel.text = [offer.requiredCategoriesList componentsJoinedByString:@", "];
    self.rewardLabel.text = offer.rewardString;
    
    NSString *expirationString = [NSString stringWithExpirationDate:offer.expirationDate currentDate:[NSDate date]];
    self.expirationTimeLabel.text = expirationString;
    
    if (offer.isExpired) {
        self.expirationTimeLabel.textColor = [UIColor expiredColor];
        self.remainingLabel.hidden = YES;
        self.progressView.hidden = YES;
        self.userIcon.hidden = YES;
    } else {
        if ([expirationString isEqual:Expiration_Time_Less_Than_A_Minute]) {
            self.expirationTimeLabel.textColor = [UIColor expiringSoonColor];
        }
        self.remainingLabel.hidden = NO;
        self.progressView.hidden = NO;
        self.userIcon.hidden = NO;
        
        self.remainingLabel.text = [NSString stringWithFormat:@"%li remaining", (long)(offer.totalParticipants - offer.currentParticipants)];
        self.progressView.progress = offer.participantsProgress;
    }
}

@end
