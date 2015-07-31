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
@property (nonatomic, strong) NSString *rewardString;
@property (nonatomic, strong) NSArray *categoryList; // TODO: Make category types
@property (nonatomic) NSInteger currentParticipants;
@property (nonatomic) NSInteger totalParticipants;
@property (nonatomic) CGFloat participantsProgress;

// Offer Details
@property (nonatomic, strong) NSDictionary *categoryFilterList;
@property (nonatomic, strong) NSDictionary *categoryRequestedList;
@property (nonatomic, strong) NSString *offerDescription;

@property (nonatomic) BOOL doesMatchFilter;
@property (nonatomic, readonly) BOOL isEligible;
@property (nonatomic, readonly) BOOL isExpired;
@property (nonatomic, readonly) NSArray *missingInformationCategories;

@end
