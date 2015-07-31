//
//  SettingsDataSource.h
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Settings.h"

@interface SettingsDataSource : NSObject <UITableViewDataSource>

- (id)initWithSettings:(Settings *)settings;

@end
