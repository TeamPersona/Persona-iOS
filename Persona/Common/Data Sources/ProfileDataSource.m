//
//  ProfileDataSource.m
//  Persona
//
//  Created by Denny Kim on 2015-07-18.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileDataSource.h"
#import "ProfileTierCollectionViewCell.h"
#import "ProfilePointsCollectionViewCell.h"
#import "ProfileBalanceCollectionViewCell.h"
#import "ProfileOffersCollectionViewCell.h"

@interface ProfileDataSource ()
@property (nonatomic) ProfileSegment currentSelectedSegment;
@end

@implementation ProfileDataSource

- (void)updateDisplayForProfileSegment:(ProfileSegment)segment
{
    self.currentSelectedSegment = segment;
}

#pragma mark - Profile Segmented Control Delegate Methods
- (void)profileSegmentedControlDidChangeToProfileSegment:(ProfileSegment)segment
{
    if (self.currentSelectedSegment != segment) {
        self.currentSelectedSegment = segment;
        [self.delegate profileDataSourceDidUpdateProfileSegment:segment];
    }
}

#pragma mark - UICollectionView DataSource Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numItems;
    if (section == ProfileSectionTierInformation) {
        numItems = 1;
    } else if (section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
//            numItems = self.pointsDataArray.count;
            numItems = 20;
        } else if (self.currentSelectedSegment == ProfileSegmentBalance) {
            numItems = 1;
        } else if (self.currentSelectedSegment == ProfileSegmentOffers) {
            numItems = self.offersDataArray.count;
        }
    }
    
    return numItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ProfileSectionTierInformation) {
        ProfileTierCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileTierCollectionViewCellIdentifier forIndexPath:indexPath];
        cell.progressPercent = 0.25;

        return cell;
    } else if (indexPath.section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            ProfilePointsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfilePointsCollectionViewCellIdentifier forIndexPath:indexPath];
            cell.pointsValueLabel.text = [NSString stringWithFormat:@"%li", indexPath.row];

            return cell;
        } else if (self.currentSelectedSegment == ProfileSegmentBalance) {
            ProfileBalanceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileBalanceCollectionViewCellIdentifier forIndexPath:indexPath];
            
            return cell;
        } else if (self.currentSelectedSegment == ProfileSegmentOffers) {
            ProfileOffersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileOffersCollectionViewCellIdentifier forIndexPath:indexPath];
            
            return cell;
        }
    }
    
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ProfileSectionAccountInformation) {
        ProfileSegmentedHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ProfileSegmentedHeaderViewIdentifier forIndexPath:indexPath];
        if (header.delegate != self) {
            header.delegate = self;
        }
        
        [header setSelectedProfileSegment:self.currentSelectedSegment];
        return header;
    }
    
    return nil;
}

@end
