//
//  Settings.m
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "Settings.h"
#import "SettingsOption.h"

static NSString *SettingsSectionKeyNames = @"SectionNames";
static NSString *SettingsSectionKeyItems = @"SectionItems";

@interface Settings ()
@property (nonatomic, strong) NSDictionary *settingsDict;
@property (nonatomic, strong) NSArray *sectionNames;
@property (nonatomic, strong) NSArray *sectionItems;
@end

@implementation Settings

- (id)initWithSettingsPlist:(NSString *)plistFileName
{
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[plistFileName stringByDeletingPathExtension] ofType:[plistFileName pathExtension]];
        
        self.settingsDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        self.sectionNames = self.settingsDict[SettingsSectionKeyNames];
        self.sectionItems = self.settingsDict[SettingsSectionKeyItems];
    }
    
    return self;
}

- (NSInteger)sections
{
    return self.sectionNames.count;
}

- (NSString *)sectionName:(NSInteger)section
{
    return self.sectionNames[section];
}

- (NSArray *)sectionItems:(NSInteger)section
{
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:self.sectionItems.count];
    for (NSDictionary *item in self.sectionItems[section]) {
        SettingsOption *settingsOption = [[SettingsOption alloc] initWithSettingsOptionDictionary:item];
        [items addObject:settingsOption];
    }
    
    return items;
}

@end
