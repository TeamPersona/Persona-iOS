//
//  ProfilePointsCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ProfilePointsCollectionViewCellIdentifier = @"profilePointsCollectionCell";

// Spacing and Sizing
static const CGFloat ProfilePointsCollectionViewMinimumCellSpacing = 32.0f;
static const CGSize ProfilePointsCollectionViewCellSize = {135.0f, 135.0f};
static const UIEdgeInsets ProfilePointsCollectionViewSectionInset = {32.0f, 32.0f, 32.0f, 32.0f};

@interface ProfilePointsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *dataImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsValueLabel;

@end
