//
//  SideScrollingCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-01-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

static NSString *SideScrollingOfferCollectionViewCellIdentifier = @"sideScrollingOfferCollectionViewCell";

@interface SideScrollingCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *partnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *earnedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateEarnedLabel;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;

- (void)setOffer:(Offer *)offer;

@end
