//
//  SettingsOption.h
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsOption : NSObject

- (id)initWithSettingsOptionDictionary:(NSDictionary *)settingsOptionDict;

@property (nonatomic, strong) NSString *title;
@property (nonatomic) BOOL hasSwitch;

@end
