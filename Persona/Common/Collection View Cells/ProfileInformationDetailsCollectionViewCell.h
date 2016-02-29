//
//  ProfileInformationDetailsCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ProfileInformationDetailsCollectionViewCellIdentifier = @"profileInformationDetailsCollectionViewCell";

static const UIEdgeInsets ProfileInformationDetailsHorizontalPadding = {12.0f, 24.0f, 12.0f, 24.0f};
static const CGFloat ProfileInformationDetailsCellHeight = 50.0f;

@interface ProfileInformationDetailsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkmarkImageView;

@end
