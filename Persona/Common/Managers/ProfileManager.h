//
//  ProfileManager.h
//  Persona
//
//  Created by Denny Kim on 2015-07-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileManager : NSObject

+ (NSArray *)parseProfileDataFromJSONFile:(NSString *)fileLocation;

@end
