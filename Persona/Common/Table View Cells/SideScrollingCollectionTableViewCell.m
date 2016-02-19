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
        return CGSizeMake(220, 120);
    } else {
        return CGSizeMake(190, 120);
    }
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
