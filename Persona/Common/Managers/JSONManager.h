//
//  JSONManager.h
//  Persona
//
//  Created by Denny Kim on 2015-07-24.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONManager : NSObject

+ (NSDictionary *)getJSONDataFromFile:(NSString *)fileLocation;

@end
