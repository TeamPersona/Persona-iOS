//
//  SettingsTableViewCell.h
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *SettingsTableViewCellIdentifier = @"settingsCell";

@interface SettingsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *settingsSwitch;

@end
