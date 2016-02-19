//
//  RecommendedDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "RecommendedDataSource.h"

@interface RecommendedDataSource ()

@property (nonatomic, strong) NSArray *recommendedOffers;

@end


@implementation RecommendedDataSource

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (id)initWithRecommendedOffers:(NSArray *)recommendedOffers
{
    self = [self init];
    self.recommendedOffers = recommendedOffers;
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.recommendedOffers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
