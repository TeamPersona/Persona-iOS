//
//  PendingTransactionsDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "PendingTransactionsDataSource.h"
#import "PendingSideScrollingCollectionViewCell.h"

@interface PendingTransactionsDataSource ()

@property (nonatomic, strong) NSArray *pendingTransactions;

@end


@implementation PendingTransactionsDataSource

- (id)initWithPendingTransactions:(NSArray *)pendingTransactions
{
    self = [self init];
    if (self) {
        self.pendingTransactions = pendingTransactions;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pendingTransactions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Offer *offer = self.pendingTransactions[indexPath.row];
    PendingSideScrollingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PendingSideScrollingOfferCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setOffer:offer];
    return cell;
}

@end
