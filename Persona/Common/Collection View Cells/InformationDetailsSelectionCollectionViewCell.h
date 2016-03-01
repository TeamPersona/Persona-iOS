//
//  InformationDetailsSelectionCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *InformationDetailsSelectionCollectionViewCellIdentifier = @"informationDetailsSelectionCollectionViewCell";

static const UIEdgeInsets InformationDetailsSelectionPadding = {12.0f, 24.0f, 12.0f, 24.0f};
static const CGSize InformationDetailsCellSize = {180.0f, 48.0f};

@interface InformationDetailsSelectionCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *optionLabel;

@end
