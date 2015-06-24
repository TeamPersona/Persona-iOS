//
//  FeaturedViewController.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "BaseTabBarViewController.h"

@interface FeaturedViewController : BaseTabBarViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
