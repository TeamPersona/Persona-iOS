//
//  ProfileSegmentedHeaderCollectionReusableView.m
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileSegmentedHeaderCollectionReusableView.h"

@interface ProfileSegmentedHeaderCollectionReusableView ()
@end

@implementation ProfileSegmentedHeaderCollectionReusableView

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelectedProfileSegment:(ProfileSegment)segment
{
    [self selectButtonForProfileSegment:segment];
}

#pragma mark - Button Methods
- (IBAction)pointsButtonPressed:(UIButton *)sender
{
    [self updateSegmentedControlWithProfileSegment:ProfileSegmentPoints];
}

- (IBAction)balanceButtonPressed:(UIButton *)sender
{
    [self updateSegmentedControlWithProfileSegment:ProfileSegmentBalance];
}

- (IBAction)offersButtonPressed:(UIButton *)sender
{
    [self updateSegmentedControlWithProfileSegment:ProfileSegmentOffers];
}

#pragma mark - Private Methods
- (void)updateSegmentedControlWithProfileSegment:(ProfileSegment)segment
{
    if (![self isSegmentButtonSelected:segment]) {
        [self selectButtonForProfileSegment:segment];
        [self.delegate profileSegmentedControlDidChangeToProfileSegment:segment];
    }
}

- (BOOL)isSegmentButtonSelected:(ProfileSegment)segment
{
    BOOL isSelected = NO;
    if (segment == ProfileSegmentPoints) {
        isSelected = self.pointsButton.selected;
    } else if (segment == ProfileSegmentBalance) {
        isSelected = self.balanceButton.selected;
    } else if (segment == ProfileSegmentOffers) {
        isSelected = self.offersButton.selected;
    }
    return isSelected;
}

- (void)unselectAllButtons
{
    if ([self isSegmentButtonSelected:ProfileSegmentPoints]) {
        self.pointsButton.selected = NO;
    }
    
    if ([self isSegmentButtonSelected:ProfileSegmentBalance]) {
        self.balanceButton.selected = NO;
    }
    
    if ([self isSegmentButtonSelected:ProfileSegmentOffers]) {
        self.offersButton.selected = NO;
    }
}

- (void)selectButtonForProfileSegment:(ProfileSegment)segment
{
    [self unselectAllButtons];
    
    if (segment == ProfileSegmentPoints) {
        self.pointsButton.selected = YES;
    } else if (segment == ProfileSegmentBalance) {
        self.balanceButton.selected = YES;
    } else if (segment == ProfileSegmentOffers) {
        self.offersButton.selected = YES;
    }
}

@end
