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
    self.collectionView.dataSource = self.dataSource;
    if (self.collectionType == SideScrollingCollectionTypeCompletedTransactions) {
        [self.collectionView registerNib:[UINib nibWithNibName:@"SideScrollingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:SideScrollingOfferCollectionViewCellIdentifier];
    } else if (self.collectionType == SideScrollingCollectionTypePendingTransactions) {
        [self.collectionView registerNib:[UINib nibWithNibName:@"PendingSideScrollingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:PendingSideScrollingOfferCollectionViewCellIdentifier];
    }
}

#pragma mark -- UICollectionView Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate sideScrollingCollectionDidSelectCellIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:self.sectionNumber]];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

@end
