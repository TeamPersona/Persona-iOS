//
//  ProfileInformationCategoryCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ProfileInformationCategoryCollectionViewCellIdentifier = @"profileInformationCollectionCell";

// Spacing and Sizing
static const CGFloat ProfileInformationCategoryCollectionViewMinimumCellSpacing = 18.0f;
static const CGFloat ProfileInformationCategoryCollectionViewMinimumLineSpacing = 32.0f;
static const CGSize ProfileInformationCategoryCollectionViewCellSize = {240.0f, 58.0f};
static const UIEdgeInsets ProfileInformationCategoryCollectionViewSectionInset = {18.0f, 12.0f, 18.0f, 12.0f};

@interface ProfileInformationCategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
