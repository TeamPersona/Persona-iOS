//
//  Offer.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "Offer.h"

@implementation Offer

- (NSString *)rewardString
{
    return [NSString stringWithFormat:@"$%.02lf", [self.rewardValue doubleValue]];
}

- (CGFloat)participantsProgress
{
    return (CGFloat)self.currentParticipants / (CGFloat)self.totalParticipants;
}

@end
