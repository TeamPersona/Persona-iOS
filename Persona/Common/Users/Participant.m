//
//  Participant.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "Participant.h"

@implementation Participant

- (NSNumber *)tierProgress
{
    return [NSNumber numberWithFloat:self.totalPointsEarned.floatValue / (self.pointsUntilNextTier.floatValue + self.totalPointsEarned.floatValue)];
}

@end
