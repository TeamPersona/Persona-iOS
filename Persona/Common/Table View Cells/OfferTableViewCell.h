//
//  OfferTableViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

static NSString *OfferTableViewCellIdentifier = @"offerCell";

// Sizing Constants
static const CGFloat OfferTableViewCellHeight =         90.0f;
static const CGFloat OfferTableViewCellHeightExpired =  73.0f;

@interface OfferTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *partnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *expirationImageView;
@property (weak, nonatomic) IBOutlet UILabel *expirationTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UIImageView *rewardTierImageView;

- (void)populateOfferInfo:(Offer *)offer;

@end
