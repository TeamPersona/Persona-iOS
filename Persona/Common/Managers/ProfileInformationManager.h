//
//  ProfileInformationManager.h
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONManager.h"
#import "InformationCategory.h"

@interface ProfileInformationManager : JSONManager

+ (InformationCategory *)parseProfileInformationCategory:(NSString *)fileLocation;

@end
