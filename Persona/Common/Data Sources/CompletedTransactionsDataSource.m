//
//  CompletedTransactionsDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "CompletedTransactionsDataSource.h"
#import "SideScrollingCollectionViewCell.h"

@implementation CompletedTransactionsDataSource

- (id)initWithCompletedTransactions:(NSArray *)completedTransactions
{
    self = [super init];
    if (self) {
        self.completedTransactions = completedTransactions;
    }
    return self;
}

#pragma mark - Collection View Datasource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.completedTransactions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Offer *offer = self.completedTransactions[indexPath.row];
    SideScrollingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SideScrollingOfferCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setOffer:offer];
    return cell;
}

@end
