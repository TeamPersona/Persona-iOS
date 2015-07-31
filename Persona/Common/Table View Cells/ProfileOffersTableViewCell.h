//
//  ProfileOffersTableViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileOffersDataSource.h"

static NSString *ProfileOffersTableViewCellIdentifier = @"profileOffersCell";

@interface ProfileOffersTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ProfileOffersDataSource *offersDataSource;

@end
