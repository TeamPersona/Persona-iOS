//
//  MessageDetailDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "MessageDetailDataSource.h"
#import "MessageDetailCollectionViewCell.h"
#import "UIColor+ProjectColors.h"

@implementation MessageDetailDataSource

- (id)initWithMessageDetails:(NSArray *)msgDetails
{
    self = [super init];
    if (self) {
        self.msgDetails = msgDetails;
    }
    return self;
}

#pragma mark - Collection View DataSource Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MessageDetailCollectionViewCellIdentifier forIndexPath:indexPath];
    
    MessageDetail *msg = self.msgDetails[indexPath.section];
    
    cell.messageLabel.text = msg.text;
    cell.backgroundColor = msg.isUsersMessage ? [UIColor personaColor] : [UIColor greenColor];
    cell.messageLabel.textColor = msg.isUsersMessage ? [UIColor whiteColor] : [UIColor blackColor];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.msgDetails.count;
}

@end
