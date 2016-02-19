//
//  SideScrollingCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-01-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

static NSString *SideScrollingOfferCollectionViewCellIdentifier = @"sideScrollingOfferCollectionViewCellIdentifer";

@interface SideScrollingCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *partnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *partnerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateEarnedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;

- (void)setOffer:(Offer *)offer;

@end
