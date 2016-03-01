//
//  InformationOptionsViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationOptionsViewController.h"
#import "InformationDetailsSelectionCollectionViewCell.h"

@interface InformationOptionsViewController ()
@property (nonatomic, strong) NSMutableArray *selectionArray;
@end

@implementation InformationOptionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"InformationDetailsSelectionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:InformationDetailsSelectionCollectionViewCellIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionView Flow Layout Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return InformationDetailsCellSize;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return InformationDetailsSelectionPadding;
}


#pragma mark - UICollectionView DataSource Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InformationDetailsSelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:InformationDetailsSelectionCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.optionLabel.text = self.infoDetails.options[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.infoDetails.options count];
}


#pragma mark - UICollectionView Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.infoDetails.type == InformationDetailsTypeBoolean || self.infoDetails.type == InformationDetailsTypeOptionSingle) {
        for (NSIndexPath *i in self.selectionArray) {
            [collectionView deselectItemAtIndexPath:i animated:YES];
        }
        [self.selectionArray addObject:indexPath];
    } else if (self.infoDetails.type == InformationDetailsTypeOptionMultiple) {
        [self.selectionArray addObject:indexPath];
    }
}

@end
