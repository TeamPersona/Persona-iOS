//
//  ProfileBalanceCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceInfo.h"

static NSString *ProfileBalanceCollectionViewCellIdentifier = @"profileBalanceCell";

// Spacing and Sizing
static const CGFloat ProfileBalanceCollectionViewCellHeight = 200.0f;

@interface ProfileBalanceCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *redeemedToDateBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentBalanceLabel;

- (void)updateBalanceInfo:(BalanceInfo *)balanceInfo;

@end
