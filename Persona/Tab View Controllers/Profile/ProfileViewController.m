//
//  ProfileViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingsViewController.h"
#import "ProfileManager.h"
#import "PointsManager.h"
#import "BalanceManager.h"
#import "OffersManager.h"
#import "ProfileDataSource.h"
#import "ProfileTierCollectionViewCell.h"
#import "ProfileInformationCategoryCollectionViewCell.h"
#import "ProfileBalanceCollectionViewCell.h"
#import "OfferDetailsViewController.h"
#import "InformationCategoryDetailsViewController.h"
#import "Constants.h"
#import "ServerAPIManager.h"

@interface ProfileViewController ()

@property (nonatomic, strong) ProfileDataSource *profileDataSource;
@property (nonatomic) ProfileSegment currentSelectedSegment;
@property (nonatomic, strong) NSArray *profileInformationCategoriesList;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonPressed:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    self.profileInformationCategoriesList = @[@"Basic", @"Personal", @"Financial", @"Health & Fitness", @"Entertainment", @"Social"];
    
    self.profileDataSource = [[ProfileDataSource alloc] init];
    self.profileDataSource.delegate = self;
    [[ServerAPIManager sharedManager] accountGetAccountInformation:^(BOOL success, id response, NSError *error) {
        if (success) {
            self.profileDataSource.profileInfo = response;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];

    [[ServerAPIManager sharedManager] accountWithdrawal:^(BOOL success, id response, NSError *error) {
        if (success) {
            NSLog(@"%@", response);
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    

//    self.profileDataSource.pointsInfo = [PointsManager parsePointsDataFromJSONFile:@"profilePointsMockData.json"];
    self.profileDataSource.informationCategoriesList = self.profileInformationCategoriesList;
    self.profileDataSource.balanceInfo = [BalanceManager parseBalanceInfoFromJSONFile:@"profileBalanceInfoMockData.json"];
    [self.collectionView reloadData];

    // Collection View
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileSegmentedHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ProfileSegmentedHeaderViewIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileTierCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfileTierCollectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileInformationCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfileInformationCategoryCollectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileBalanceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfileBalanceCollectionViewCellIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = flowLayout;
    
    // Default
    self.currentSelectedSegment = ProfileSegmentPoints;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.collectionView.dataSource = self.profileDataSource;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Methods
- (void)settingsButtonPressed:(UIBarButtonItem *)sender
{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

#pragma mark - Profile Data Source Delegate Methods
- (void)profileDataSourceDidUpdateProfileSegment:(ProfileSegment)segment
{
    if (self.currentSelectedSegment != segment) {
        self.currentSelectedSegment = segment;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionView Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentSelectedSegment == ProfileSegmentPoints && indexPath.section != 0) {
        InformationCategoryDetailsViewController *informationDetailsVC = [[InformationCategoryDetailsViewController alloc] initWithCategoryTitle:self.profileInformationCategoriesList[indexPath.row]];
        [self.navigationController pushViewController:informationDetailsVC animated:YES];
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UICollectionViewFlowLayout Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize;
    if (indexPath.section == ProfileSectionTierInformation) {
        itemSize = CGSizeMake(SCREEN_SIZE.width, ProfileTierCellHeight);
    } else if (indexPath.section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            itemSize = ProfileInformationCategoryCollectionViewCellSize;
        } else if (self.currentSelectedSegment == ProfileSegmentBalance) {
            itemSize = CGSizeMake(SCREEN_SIZE.width, ProfileBalanceCollectionViewCellHeight);
        }
    }
    
    return itemSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize itemSize = CGSizeZero;
    if (section == ProfileSectionAccountInformation) {
        itemSize = CGSizeMake(SCREEN_SIZE.width, ProfileSegmentedHeaderViewHeight);
    }
    
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInset = UIEdgeInsetsZero;
    
    if (section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            edgeInset = ProfileInformationCategoryCollectionViewSectionInset;
        }
    }
    
    return edgeInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat minItemSpacing = 0.0f;
    
    if (section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            minItemSpacing = ProfileInformationCategoryCollectionViewMinimumCellSpacing;
        }
    }
    
    return minItemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat minLineSpacing = 0.0f;
    
    if (section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            minLineSpacing = ProfileInformationCategoryCollectionViewMinimumLineSpacing;
        }
    }
    
    return minLineSpacing;
}

@end
