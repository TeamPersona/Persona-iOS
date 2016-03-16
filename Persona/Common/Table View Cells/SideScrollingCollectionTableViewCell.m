//
//  SideScrollingCollectionTableViewCell.m
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "SideScrollingCollectionTableViewCell.h"
#import "SideScrollingCollectionViewCell.h"
#import "PendingSideScrollingCollectionViewCell.h"

static const CGSize CompletedTransactionsCellSize = {204, 120};
static const CGSize PendingTransactionsCellSize = {140, 120};

@implementation SideScrollingCollectionTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SideScrollingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:SideScrollingOfferCollectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PendingSideScrollingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:PendingSideScrollingOfferCollectionViewCellIdentifier];
}

- (void)setCollectionViewDataSource:(id<UICollectionViewDataSource>)dataSource
{
    self.collectionView.dataSource = dataSource;
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionType == SideScrollingCollectionTypeCompletedTransactions) {
        return CompletedTransactionsCellSize;
    } else {
        return PendingTransactionsCellSize;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat width = self.collectionView.bounds.size.width;
    CGFloat cellWidth = (self.collectionType == SideScrollingCollectionTypeCompletedTransactions) ? CompletedTransactionsCellSize.width : PendingTransactionsCellSize.width;
    
    NSInteger numberOfCells = [self.collectionView.dataSource collectionView:collectionView numberOfItemsInSection:section];
    CGFloat totalCellWidth = cellWidth * numberOfCells;
    CGFloat totalSpacingWidth = 10.0f * (numberOfCells - 1);
    CGFloat padding = MAX((width - (totalCellWidth + totalSpacingWidth)) / 2, 0);
    return UIEdgeInsetsMake(0, padding, 0, padding);
}


#pragma mark -- UICollectionView Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.sideScrollingCollectionDelegate respondsToSelector:@selector(sideScrollingCollectionDidSelectCellIndexPath:)]) {
        [self.sideScrollingCollectionDelegate sideScrollingCollectionDidSelectCellIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:self.sectionNumber]];
    }
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

@end
