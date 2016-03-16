//
//  ProfileBalanceCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileBalanceCollectionViewCell.h"

@implementation ProfileBalanceCollectionViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)updateBalanceInfo:(BalanceInfo *)balanceInfo
{
    self.redeemedToDateBalanceLabel.text = [NSString stringWithFormat:@"$%.02f", 0.0];
    self.currentBalanceLabel.text = [NSString stringWithFormat:@"$%.02f", 0.5];
//    self.redeemedToDateBalanceLabel.text = [NSString stringWithFormat:@"$%.02f", balanceInfo.redeemedRewardBalance.doubleValue];
//    self.currentBalanceLabel.text = [NSString stringWithFormat:@"$%.02f", balanceInfo.currentRewardBalance.doubleValue];
}

- (IBAction)redeemButtonPressed:(UIButton *)sender
{
}

@end
