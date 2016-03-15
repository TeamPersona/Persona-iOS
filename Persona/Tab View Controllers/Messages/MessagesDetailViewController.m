//
//  MessagesDetailViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "MessagesDetailViewController.h"
#import "MessageDetailDataSource.h"
#import "MessageDetailCollectionViewCell.h"
#import "SpacingAndSizingCalculations.h"
#import "Constants.h"

@interface MessagesDetailViewController ()

@property (nonatomic, strong) MessageDetailDataSource *dataSource;

@end

@implementation MessagesDetailViewController

- (id)initWithMessage:(Message *)message
{
    self = [super init];
    if (self) {
        self.dataSource = [[MessageDetailDataSource alloc] initWithMessageDetails:message.messageDetails];
        self.title = message.partner.name;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MessageDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:MessageDetailCollectionViewCellIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self.dataSource;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetail *msg = self.dataSource.msgDetails[indexPath.section];
    return [SpacingAndSizingCalculations calculateMessageLabelSize:msg.text];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    MessageDetail *msg = self.dataSource.msgDetails[section];
    CGSize cellSize = [SpacingAndSizingCalculations calculateMessageLabelSize:msg.text];
    CGFloat sidePadding = 22.0f;
    CGFloat topPadding = 16.0f;
    if (msg.isUsersMessage) {
        return UIEdgeInsetsMake(topPadding, SCREEN_SIZE.width - (cellSize.width + sidePadding), 0, sidePadding);
    } else {
        return UIEdgeInsetsMake(topPadding, sidePadding, 0, SCREEN_SIZE.width - (cellSize.width + sidePadding));
    }
}

@end
