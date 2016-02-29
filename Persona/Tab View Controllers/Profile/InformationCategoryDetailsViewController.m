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

@interface InformationCategoryDetailsViewController ()
@property (nonatomic, strong) InformationDetailsDataSource *dataSource;
@end

@implementation InformationCategoryDetailsViewController

- (id)initWithCategoryTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    InformationCategory *infoCategory = [ProfileInformationManager parseProfileInformationCategory:[NSString stringWithFormat:@"%@InformationMockData.json", self.title.lowercaseString]];
    self.dataSource = [[InformationDetailsDataSource alloc] initWithInfoCategory:infoCategory];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileInformationDetailsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ProfileInformationDetailsCollectionViewCellIdentifier];
    self.collectionView.dataSource = self.dataSource;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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
