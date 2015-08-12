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
#import "PointsData.h"
#import "Offer.h"
#import "NSString+ExpirationTime.h"
#import "UIColor+ProjectColors.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
            numItems = self.pointsDataArray.count;
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
        
        cell.progressPercent = self.profileInfo.tierProgress.floatValue;

        NSString *tierString;
        if (self.profileInfo.rewardTier == RewardTierBasic) {
            tierString = @"Bronze";
        } else if (self.profileInfo.rewardTier == RewardTierBronze) {
            tierString = @"Silver";
        } else if (self.profileInfo.rewardTier == RewardTierSilver) {
            tierString = @"Gold";
        } else if (self.profileInfo.rewardTier == RewardTierGold) {
            tierString = @"Diamond";
        }
        
        cell.tierLabel.text = [NSString stringWithFormat:@"%@ Tier: %@ points remaining", tierString, self.profileInfo.pointsUntilNextTier.stringValue];
        
//        cell.tierImageView.image = [UIImage imageNamed:@""];
        
        return cell;
    } else if (indexPath.section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            PointsData *pointsData = self.pointsDataArray[indexPath.row];
            
            ProfilePointsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfilePointsCollectionViewCellIdentifier forIndexPath:indexPath];
            cell.titleLabel.text = pointsData.dataTitle;
            [cell.dataImageView sd_setImageWithURL:pointsData.dataImageURL];
            cell.pointsValueLabel.text = [NSString stringWithFormat:@"%li pts", [pointsData.dataPointsValue integerValue]];

            return cell;
        } else if (self.currentSelectedSegment == ProfileSegmentBalance) {
            ProfileBalanceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileBalanceCollectionViewCellIdentifier forIndexPath:indexPath];
            [cell updateBalanceInfo:self.balanceInfo];
            
            return cell;
        } else if (self.currentSelectedSegment == ProfileSegmentOffers) {
            ProfileOffersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileOffersCollectionViewCellIdentifier forIndexPath:indexPath];
            [cell setNeedsDisplay];
            Offer *offer = self.offersDataArray[indexPath.row];
            
            cell.titleLabel.text = offer.partner.name;
            [cell.partnerImageView sd_setImageWithURL:offer.partner.partnerImageURL ];
            cell.categoryLabel.text = [offer.categoryList componentsJoinedByString:@", "];
            cell.rewardLabel.text = offer.rewardString;

            NSString *expirationString = [NSString stringWithExpirationDate:offer.expirationDate currentDate:[NSDate date]];
            cell.expirationTimeLabel.text = expirationString;
            
            if (!offer.isExpired) {
                cell.remainingLabel.hidden = NO;
                cell.progressView.hidden = NO;
                
                cell.remainingLabel.text = [NSString stringWithFormat:@"%li remaining", (long)(offer.totalParticipants - offer.currentParticipants)];
                cell.progressView.progress = offer.participantsProgress;
                
                if ([expirationString isEqualToString:Expiration_Time_Less_Than_A_Minute]) {
                    cell.expirationTimeLabel.textColor = [UIColor expiringSoonColor];
                } else {
                    cell.expirationTimeLabel.textColor = [UIColor blackColor];
                }
            } else {
                cell.remainingLabel.hidden = YES;
                cell.progressView.hidden = YES;
                
                cell.expirationTimeLabel.textColor = [UIColor expiredColor];
            }
            
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
        
        [header updateProfileInfo:self.profileInfo];
        [header setSelectedProfileSegment:self.currentSelectedSegment];
        
        return header;
    }
    
    return nil;
}

@end
