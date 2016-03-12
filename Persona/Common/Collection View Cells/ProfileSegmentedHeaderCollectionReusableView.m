//
//  ProfileSegmentedHeaderCollectionReusableView.m
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileSegmentedHeaderCollectionReusableView.h"
#import "UIColor+ProjectColors.h"

static const NSString *PointsButtonTitleText = @"Points";
static const NSString *BalanceButtonTitleText = @"Balance";

@interface ProfileSegmentedHeaderCollectionReusableView ()
@end

@implementation ProfileSegmentedHeaderCollectionReusableView

- (void)awakeFromNib
{
    self.pointsButton.titleLabel.numberOfLines = 0;
    self.pointsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.balanceButton.titleLabel.numberOfLines = 0;
    self.balanceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setSelectedProfileSegment:(ProfileSegment)segment
{
    if (segment == ProfileSegmentPoints) {
        [self segmentButtonPressed:self.pointsButton];
    } else if (segment == ProfileSegmentBalance) {
        [self segmentButtonPressed:self.balanceButton];
    }
}

- (void)updateProfileInfo:(Participant *)participantInfo
{
    [self.pointsButton setTitle:[NSString stringWithFormat:@"%li\n%@", participantInfo.totalPoints, PointsButtonTitleText]
                       forState:UIControlStateNormal];
    
    [self.balanceButton setTitle:[NSString stringWithFormat:@"$%.02f\n%@", participantInfo.accountBalance.doubleValue/100, BalanceButtonTitleText]
                       forState:UIControlStateNormal];
}

#pragma mark - Button Methods
- (IBAction)segmentButtonPressed:(UIButton *)sender
{
    [self updateButton:sender state:YES];
    if ([sender isEqual:self.pointsButton]) {
        [self updateButton:self.balanceButton state:NO];
        [self.delegate profileSegmentedControlDidChangeToProfileSegment:ProfileSegmentPoints];
    } else if ([sender isEqual:self.balanceButton]) {
        [self updateButton:self.pointsButton state:NO];
        [self.delegate profileSegmentedControlDidChangeToProfileSegment:ProfileSegmentBalance];
    }
    
}

- (void)updateButton:(UIButton *)button state:(BOOL)shouldSelect
{
    if (shouldSelect) {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        button.backgroundColor = [UIColor personaColor];
    } else {
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        button.backgroundColor = [UIColor personaLightColor];
    }
}

@end
