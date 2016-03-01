//
//  UIColor+ProjectColors.m
//  Persona
//
//  Created by Denny Kim on 2015-07-19.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "UIColor+ProjectColors.h"

@implementation UIColor (ProjectColors)

+ (UIColor *)personaColor
{
    return [self colorWithRed:46.0/255.0 green:88.0/255.0 blue:148.0/255.0 alpha:1.0];
}

+ (UIColor *)personaLightColor
{
    return [self colorWithRed:64.0/255.0 green:109.0/255.0 blue:163.0/255.0 alpha:1.0];
}

+ (UIColor *)personaDarkColor
{
    return [self colorWithRed:16.0/255.0 green:68.0/255.0 blue:129.0/255.0 alpha:1.0];
}

+ (UIColor *)personaAltColor
{
    return [self colorWithRed:224.0/255.0 green:162.0/255.0 blue:55.0/255.0 alpha:1.0];
}

+ (UIColor *)progressCircleFillColor
{
    return [self personaColor];
}

+ (UIColor *)progressCircleOutlineColor
{
    return [self blackColor];
}

+ (UIColor *)expiringSoonColor
{
    return [self orangeColor];
}

+ (UIColor *)expiredColor
{
    return  [self redColor];
}

@end
