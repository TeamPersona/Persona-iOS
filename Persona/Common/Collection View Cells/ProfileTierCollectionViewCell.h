//
//  ProfileTierCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ProfileTierCollectionViewCellIdentifier = @"profileTierCell";

// Spacing and Sizing

static const CGFloat ProfileTierOutlineLineWidth = 0.6f;
static const CGFloat ProfileTierOuterCircleDelta = -25.0f;
static const CGFloat ProfileTierProgressCircleLineWidth = 20.0f - (ProfileTierOutlineLineWidth * 2);
static const CGFloat ProfileTierInnerCircleDelta = ProfileTierOuterCircleDelta + (ProfileTierProgressCircleLineWidth/2);
static const CGFloat ProfileTierProgressCircleDelta = ProfileTierOuterCircleDelta + (ProfileTierProgressCircleLineWidth/4);
static const CGFloat ProfileTierCellHeight = 180.0f;

@interface ProfileTierCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tierImageView;
@property (weak, nonatomic) IBOutlet UILabel *tierLabel;

@property (nonatomic) CGFloat progressPercent;

@end
