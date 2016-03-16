//
//  SettingsDataSource.m
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "SettingsDataSource.h"
#import "SettingsTableViewCell.h"
#import "SettingsOption.h"

@interface SettingsDataSource ()
@property (nonatomic, strong) Settings *settings;
@end

@implementation SettingsDataSource

- (id)initWithSettings:(Settings *)settings
{
    self = [super init];
    if (self) {
        self.settings = settings;
    }
    
    return self;
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return self.settings.sections;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray *items = [self.settings sectionItems:section];
//    return items.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingsTableViewCellIdentifier forIndexPath:indexPath];
//    
//    NSArray *items = [self.settings sectionItems:indexPath.section];
//    SettingsOption *option = items[indexPath.row];
//    
//    cell.label.text = option.title;
//    
//    if (option.hasSwitch) {
//        cell.settingsSwitch.hidden = NO;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    } else {
//        cell.settingsSwitch.hidden = YES;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//
//    return cell;
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.settings sectionName:section];
}

@end
