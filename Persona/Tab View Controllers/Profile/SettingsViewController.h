//
//  SettingsViewController.h
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *settingsFooterView;

@end
