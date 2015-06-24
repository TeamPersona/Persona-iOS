//
//  Offer.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Partner.h"

@interface Offer : NSObject

@property (nonatomic) NSInteger offerId;
@property (nonatomic, strong) Partner *partner;
@property (nonatomic, strong) NSDate *expirationDate;
@property (nonatomic, strong) NSNumber *rewardValue;
@property (nonatomic, strong) NSArray *categoryList; // TODO: Make category types
@property (nonatomic) NSInteger currentParticipants;
@property (nonatomic) NSInteger totalParticipants;

// Offer Details
@property (nonatomic, strong) NSArray *filterList;
@property (nonatomic, strong) NSArray *categoryRequestedList;
@property (nonatomic, strong) NSString *offerDescription;

@end
