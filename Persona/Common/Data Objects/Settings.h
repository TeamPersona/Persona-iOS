//
//  Settings.h
//  Persona
//
//  Created by Denny Kim on 2015-07-17.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property (nonatomic, readonly) NSInteger sections;

- (id)initWithSettingsPlist:(NSString *)plistFileName;
- (NSString *)sectionName:(NSInteger)section;
- (NSArray *)sectionItems:(NSInteger)section;

@end
