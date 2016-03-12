//
//  InformationSource.h
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationSource : NSObject

+ (InformationSource *)parseDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)formDictionary;

@property (nonatomic, strong) NSDate *dateAdded;
@property (nonatomic, strong) NSString *name;

@end
