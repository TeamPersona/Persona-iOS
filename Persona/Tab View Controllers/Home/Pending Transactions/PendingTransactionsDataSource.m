//
//  PendingTransactionsDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "PendingTransactionsDataSource.h"

@interface PendingTransactionsDataSource ()

@property (nonatomic, strong) NSArray *pendingTransactions;

@end


@implementation PendingTransactionsDataSource

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (id)initWithPendingTransactions:(NSArray *)pendingTransactions
{
    self = [self init];
    self.pendingTransactions = pendingTransactions;
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pendingTransactions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
