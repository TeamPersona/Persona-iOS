//
//  DateFormatManager.h
//  Persona
//
//  Created by Denny Kim on 2016-02-16.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatManager : NSObject

+ (id)sharedManager;

- (NSString *)formatToShortDateString:(NSDate *)date;

@end
