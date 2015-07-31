//
//  SettingsOption.m
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "SettingsOption.h"

static NSString *SettingsOptionKeyTitle =  @"Title";
static NSString *SettingsOptionKeySwitch = @"Switch";

@implementation SettingsOption

- (id)initWithSettingsOptionDictionary:(NSDictionary *)settingsOptionDict
{
    self = [super init];
    if (self) {
        self.title = settingsOptionDict[SettingsOptionKeyTitle];
        self.hasSwitch = [settingsOptionDict[SettingsOptionKeySwitch] boolValue];
    }
    
    return self;
}

@end
