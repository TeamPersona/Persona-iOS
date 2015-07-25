//
//  ProfileViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingsViewController.h"
#import "PointsManager.h"
#import "ProfileDataSource.h"
#import "ProfileTierCollectionViewCell.h"
#import "ProfilePointsCollectionViewCell.h"
#import "ProfileBalanceCollectionViewCell.h"
#import "ProfileOffersCollectionViewCell.h"
#import "Constants.h"

/* Spacing and Sizing Constants */

// Profile Balance
static const CGFloat ProfileBalanceViewHeight = 320.0f;
// Profile Offers
static const CGFloat ProfileOffersTableViewCellHeight = 44.0f;


@interface ProfileViewController ()

@property (nonatomic, strong) ProfileDataSource *profileDataSource;
@property (nonatomic) ProfileSegment currentSelectedSegment;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonPressed:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    self.profileDataSource = [[ProfileDataSource alloc] init];
    self.profileDataSource.delegate = self;
#if DEBUG
    self.profileDataSource.pointsDataArray = [PointsManager parsePointsDataFromJSONFile:@"profilePointsMockData.json"];
    [self.collectionView reloadData];
#endif

    // Collection View
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileSegmentedHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ProfileSegmentedHeaderViewIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileTierCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfileTierCollectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfilePointsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfilePointsCollectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileBalanceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfileBalanceCollectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileOffersCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfileOffersCollectionViewCellIdentifier];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - UICollectionViewFlowLayout Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize;
    if (indexPath.section == ProfileSectionTierInformation) {
        itemSize = CGSizeMake(SCREEN_SIZE.width, ProfileTierCellHeight);
    } else if (indexPath.section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            itemSize = ProfilePointsCollectionViewCellSize;
        } else if (self.currentSelectedSegment == ProfileSegmentBalance) {
            itemSize = CGSizeMake(SCREEN_SIZE.width, ProfileBalanceCollectionViewCellHeight);
        } else if (self.currentSelectedSegment == ProfileSegmentOffers) {
            
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
            edgeInset = ProfilePointsCollectionViewSectionInset;
        }
    }
    
    return edgeInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat minItemSpacing = 0.0f;
    
    if (section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            minItemSpacing = ProfilePointsCollectionViewMinimumCellSpacing;
        }
    }
    
    return minItemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat minLineSpacing = 0.0f;
    
    if (section == ProfileSectionAccountInformation) {
        if (self.currentSelectedSegment == ProfileSegmentPoints) {
            minLineSpacing = ProfilePointsCollectionViewMinimumCellSpacing;
        }
    }
    
    return minLineSpacing;
}

@end
