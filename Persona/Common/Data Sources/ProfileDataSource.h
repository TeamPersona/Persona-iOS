//
//  ProfileDataSource.h
//  Persona
//
//  Created by Denny Kim on 2015-07-18.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProfileConfigurations.h"
#import "ProfileSegmentedHeaderCollectionReusableView.h"
#import "BalanceInfo.h"
#import "Participant.h"

@protocol ProfileDataSourceDelegate <NSObject>

- (void)profileDataSourceDidUpdateProfileSegment:(ProfileSegment)segment;

@end

@interface ProfileDataSource : NSObject <UICollectionViewDataSource, ProfileSegmentedControlDelegate>

@property (nonatomic, assign) id<ProfileDataSourceDelegate> delegate;

@property (nonatomic, strong) Participant *profileInfo;
@property (nonatomic, strong) NSArray *informationCategoriesList;
@property (nonatomic, strong) NSArray *offersDataArray;
@property (nonatomic, strong) BalanceInfo *balanceInfo;

- (void)updateDisplayForProfileSegment:(ProfileSegment)segment;

@end
