//
//  ProfileViewController.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "ProfileDataSource.h"

@interface ProfileViewController : BaseTabBarViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ProfileDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
