//
//  CompletedTransactionsDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "CompletedTransactionsDataSource.h"

@interface CompletedTransactionsDataSource ()

@property (nonatomic, strong) NSArray *completedTransactions;

@end


@implementation CompletedTransactionsDataSource

- (id)init
{
    self = [super init];
    if (self) {

    }
    
    return self;
}

- (id)initWithCompletedTransactions:(NSArray *)completedTransactions
{
    self = [self init];
    self.completedTransactions = completedTransactions;
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.completedTransactions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
