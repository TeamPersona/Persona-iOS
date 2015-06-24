//
//  Participant.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "User.h"
#import "RewardTier.h"

@interface Participant : User

@property (nonatomic) RewardTier rewardTier;

@end
