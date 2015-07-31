//
//  ProfileOffersCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ProfileOffersCollectionViewCellIdentifier = @"profileOffersCell";

// Spacing and Sizing
static const CGFloat ProfileOffersCollectionViewCellHeight =        90.0f;
static const CGFloat ProfileOffersCollectionViewCellHeightExpired = 73.0f;

@interface ProfileOffersCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *partnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;

@end
