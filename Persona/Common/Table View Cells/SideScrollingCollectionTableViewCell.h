//
//  SideScrollingCollectionTableViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideScrollingCollectionDelegate <NSObject>

- (void)sideScrollingCollectionDidSelectCellIndexPath:(NSIndexPath *)indexPath;

@end

static NSString *SideScrollingCollectionTableViewCellIdentifier = @"sideScrollingCollectionCell";


@interface SideScrollingCollectionTableViewCell : UITableViewCell <UICollectionViewDelegate>

typedef NS_ENUM(NSUInteger, SideScrollingCollectionType) {
    SideScrollingCollectionTypeCompletedTransactions,
    SideScrollingCollectionTypePendingTransactions
};

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) id <SideScrollingCollectionDelegate> delegate;
@property (nonatomic, strong) id <UICollectionViewDataSource> dataSource;
@property (nonatomic) SideScrollingCollectionType collectionType;


@property (nonatomic) NSInteger sectionNumber;
@property (nonatomic, strong) NSArray *collectionArray;

@end
