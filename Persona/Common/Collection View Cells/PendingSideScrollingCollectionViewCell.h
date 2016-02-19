//
//  PendingSideScrollingCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-02-16.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

static NSString *PendingSideScrollingOfferCollectionViewCellIdentifier = @"pendingSideScrollingOfferCollectionViewCell";

@interface PendingSideScrollingCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *partnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *partnerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pendingLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;

- (void)setOffer:(Offer *)offer;

@end
