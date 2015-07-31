//
//  ProfileBalanceTableViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceInfo.h"

static NSString *ProfileBalanceTableViewCellIdentifier = @"profileBalanceCell";

@interface ProfileBalanceTableViewCell : UITableViewCell

@property (nonatomic, strong) BalanceInfo *balanceInfo;

@end
