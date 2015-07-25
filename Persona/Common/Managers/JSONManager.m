//
//  JSONManager.m
//  Persona
//
//  Created by Denny Kim on 2015-07-24.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "JSONManager.h"

@implementation JSONManager

+ (NSDictionary *)getJSONDataFromFile:(NSString *)fileLocation
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];

    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", error.description);
        return nil;
    }
    
    return dictionary;
}

@end
