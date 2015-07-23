//
//  ProfileSegmentedHeaderCollectionReusableView.h
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileConfigurations.h"

@protocol ProfileSegmentedControlDelegate <NSObject>

- (void)profileSegmentedControlDidChangeToProfileSegment:(ProfileSegment)segment;

@end


static NSString *ProfileSegmentedHeaderViewIdentifier = @"profileSegmentedHeaderView";
static const CGFloat ProfileSegmentedHeaderViewHeight = 72.0f;

@interface ProfileSegmentedHeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic, assign) id<ProfileSegmentedControlDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *pointsButton;
@property (weak, nonatomic) IBOutlet UIButton *balanceButton;
@property (weak, nonatomic) IBOutlet UIButton *offersButton;

- (void)setSelectedProfileSegment:(ProfileSegment)segment;

@end
