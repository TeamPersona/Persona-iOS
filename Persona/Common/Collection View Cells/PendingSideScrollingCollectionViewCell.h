//
//  PendingSideScrollingCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-02-16.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *PendingSideScrollingOfferCollectionViewCellIdentifier = @"pendingSideScrollingOfferCollectionViewCellIdentifer";

@interface PendingSideScrollingCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *partnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *partnerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pendingLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;

@end
