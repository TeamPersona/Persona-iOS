//
//  ProfileManager.h
//  Persona
//
//  Created by Denny Kim on 2015-07-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONManager.h"
#import "Participant.h"

@interface ProfileManager : JSONManager

+ (Participant *)parseProfileDataFromJSONFile:(NSString *)fileLocation;

@end
