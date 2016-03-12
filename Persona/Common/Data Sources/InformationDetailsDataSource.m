//
//  InformationDetailsDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationDetailsDataSource.h"
#import "ProfileInformationDetailsCollectionViewCell.h"
#import "ProfileInformationManager.h"

@interface InformationDetailsDataSource ()

@property (nonatomic, strong) InformationCategory *info;

@end

@implementation InformationDetailsDataSource

- (id)initWithInfoCategory:(InformationCategory *)info
{
    self = [super init];
    if (self) {
        self.info = info;
    }
    return self;
}

- (void)updateInfo:(InformationCategory *)info
{
    self.info = info;
}


#pragma mark - UICollectionView DataSource Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InformationDetails *details = self.info.informationDetails[indexPath.row];
    ProfileInformationDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProfileInformationDetailsCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = details.name;
    cell.pointsLabel.text = [NSString stringWithFormat:@"%li points", details.points];
    cell.checkmarkImageView.hidden = !details.hasValue;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.info.informationDetails.count;
}

@end
