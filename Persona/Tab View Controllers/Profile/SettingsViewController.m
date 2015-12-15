//
//  SettingsViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"
#import "SettingsOption.h"
#import "SettingsDataSource.h"
#import "SettingsTableViewCell.h"
#import "AppDelegate.h"
#import "Constants.h"

static NSString *SettingsTitle =        @"Settings";
static NSString *SettingsSectionPlist = @"SettingsSectionNames.plist";

static const CGFloat SettingsHeaderViewHeight = 32.0f;

@interface SettingsViewController ()
@property (nonatomic, strong) Settings *settings;
@property (nonatomic, strong) SettingsDataSource *dataSource;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SettingsTitle;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingsTableViewCell" bundle:nil] forCellReuseIdentifier:SettingsTableViewCellIdentifier];
    self.tableView.tableFooterView = self.settingsFooterView;
    
    self.settings = [[Settings alloc] initWithSettingsPlist:SettingsSectionPlist];
    self.dataSource = [[SettingsDataSource alloc] initWithSettings:self.settings];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.dataSource = self.dataSource;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonPressed:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@NO forKey:IS_LOGGED_IN];
    [userDefaults synchronize];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate logoutToWelcomeView:YES];
}

#pragma mark - UITableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SettingsHeaderViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [self.settings sectionItems:indexPath.section];
    SettingsOption *option = items[indexPath.row];

    return !option.hasSwitch;
}

@end
