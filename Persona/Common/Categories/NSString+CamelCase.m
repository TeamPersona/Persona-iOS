//
//  NSString+CamelCase.m
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "NSString+CamelCase.h"

@implementation NSString (CamelCase)

- (NSString *)toCamelCase
{
    NSMutableString *str = [NSMutableString string];
    NSArray *strComponents = [self componentsSeparatedByString:@" "];
    for (int i = 0; i < strComponents.count; i++) {
        NSString *s;
        if (i == 0) {
            s = [strComponents[i] lowercaseString];
        } else {
            s = [strComponents[i] capitalizedString];
        }
        [str appendString:s];
    }
    return str;
}

- (NSString *)toTitleCase
{
    NSMutableString *str = [NSMutableString string];
    
    for (NSInteger i = 0; i < self.length; i++){
        NSString *ch = [self substringWithRange:NSMakeRange(i, 1)];
        if ([ch rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound) {
            [str appendString:@" "];
        }
        [str appendString:ch];
    }
    return [str capitalizedString];
}

@end
