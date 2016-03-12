//
//  InformationCategoryDetailsViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationCategoryDetailsViewController.h"
#import "ProfileInformationDetailsCollectionViewCell.h"
#import "InformationDetailsDataSource.h"
#import "ProfileInformationManager.h"
#import "PopupTransitionAnimation.h"
#import "BaseNavigationViewController.h"

@interface InformationCategoryDetailsViewController ()
@property (nonatomic, strong) InformationDetailsDataSource *dataSource;
@property (nonatomic, strong) PopupTransitionAnimation *animator;
@property (nonatomic, strong) NSIndexPath *manualEntryIndexPath;
@end

@implementation InformationCategoryDetailsViewController

- (id)initWithInfoCategory:(InformationCategory *)category
{
    self = [super init];
    if (self) {
        self.title = category.categoryName;
        self.infoCategory = category;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.animator = [PopupTransitionAnimation new];
    if (!self.infoCategory) {
        self.infoCategory = [ProfileInformationManager parseProfileInformationCategory:[NSString stringWithFormat:@"%@InformationMockData.json", self.title.lowercaseString]];
    }
    self.dataSource = [[InformationDetailsDataSource alloc] initWithInfoCategory:self.infoCategory];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileInformationDetailsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfileInformationDetailsCollectionViewCellIdentifier];
    self.collectionView.dataSource = self.dataSource;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InformationDetails Popup Delegate Methods
- (void)updateInformationDetails:(InformationDetails *)details atIndex:(NSInteger)index
{
    self.infoCategory.informationDetails[index] = details;
    [self.collectionView reloadData];
}


#pragma mark - Information Manual Entry Delegate Methods
- (void)informationDidCancelManualEntry
{
    self.manualEntryIndexPath = nil;
}

- (void)informationDidFinishEntryWithData:(NSDictionary *)dataDict
{
    InformationDetails *info = self.infoCategory.informationDetails[self.manualEntryIndexPath.row];
    info.value = dataDict;
    [self.dataSource updateInfo:self.infoCategory];
    [self.collectionView reloadData];
    // TODO: send data to server
}

#pragma mark - UICollectionView Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    InformationDetails *info = self.infoCategory.informationDetails[indexPath.row];
    if (info.value == nil) {
        InformationManualEntryViewController *vc = [[InformationManualEntryViewController alloc] initWithInformationSubCategory:info.name];
        vc.delegate = self;
        self.manualEntryIndexPath = indexPath;
        [self.navigationController presentViewController:[[BaseNavigationViewController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        
    } else {
        InformationDetailsViewController *vc = [[InformationDetailsViewController alloc] initWithInfoDetails:self.infoCategory.informationDetails[indexPath.row]];
        vc.delegate = self;
        vc.index = indexPath.row;
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self.animator;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}


#pragma mark - UICollectionView Flow Layout Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth - ProfileInformationDetailsHorizontalPadding.left - ProfileInformationDetailsHorizontalPadding.right, ProfileInformationDetailsCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ProfileInformationDetailsHorizontalPadding.top;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(ProfileInformationDetailsHorizontalPadding.top, 0, ProfileInformationDetailsHorizontalPadding.bottom, 0);
}

@end
