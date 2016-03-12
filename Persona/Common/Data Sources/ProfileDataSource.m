//
//  ProfileDataSource.m
//  Persona
//
//  Created by Denny Kim on 2015-07-18.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileDataSource.h"
#import "ProfileTierCollectionViewCell.h"
#import "ProfileInformationCategoryCollectionViewCell.h"
#import "ProfileBalanceCollectionViewCell.h"
#import "PointsData.h"
#import "Offer.h"
#import "NSString+ExpirationTime.h"
#import "UIColor+ProjectColors.h"
#import "PersonalInformation.h"
#import "InformationDetails.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProfileDataSource ()
@property (nonatomic) ProfileSegment currentSelectedSegment;
@end

@implementation ProfileDataSource

- (void)updateDisplayForProfileSegment:(ProfileSegment)segment
{
    self.currentSelectedSegment = segment;
}

- (void)setPersonalInformationDataWithWithdrawalInfo:(NSArray *)withdrawalInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *category in self.informationCategoriesList) {
        [dict setObject:[NSMutableArray new] forKey:category];
    }
    
    for (PersonalInformation *info in withdrawalInfo) {
        InformationDetails *details = [InformationDetails new];
        details.mainCategory = info.category;
        details.name = info.subCategory;
        details.points = [info.rewardValue integerValue];
        details.value = info.data;
        
        if (dict[details.mainCategory] != nil) {
            [dict[details.mainCategory] addObject:details];
        }
    }
    self.personalInformationData = dict;
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
            numItems = self.informationCategoriesList.count;
        } else if (self.currentSelectedSegment == ProfileSegmentBalance) {
            numItems = 1;
        }
    }
    
    return numItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ProfileSectionTierInformation) {
        ProfileTierCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileTierCollectionViewCellIdentifier forIndexPath:indexPath];
        
        cell.tierLabel.text = @"";
        cell.progressPercent = self.profileInfo.tierProgress.floatValue;

        NSString *tierString;
        if (self.profileInfo.rewardTier == RewardTierDefault) {
            tierString = @"Silver";
        } else if (self.profileInfo.rewardTier == RewardTierSilver) {
            tierString = @"Gold";
        }
        
        if (self.profileInfo.rewardTier != RewardTierGold) {
            cell.tierLabel.text = [NSString stringWithFormat:@"%@ Tier: %li points remaining", tierString, self.profileInfo.pointsToNextTier];
        }
        
//        cell.tierImageView.image = [UIImage imageNamed:@""];
        
        return cell;
    } else if (indexPath.section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            ProfileInformationCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileInformationCategoryCollectionViewCellIdentifier forIndexPath:indexPath];
            cell.titleLabel.text = self.informationCategoriesList[indexPath.row];
            return cell;
        } else if (self.currentSelectedSegment == ProfileSegmentBalance) {
            ProfileBalanceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileBalanceCollectionViewCellIdentifier forIndexPath:indexPath];
            [cell updateBalanceInfo:self.balanceInfo];
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
