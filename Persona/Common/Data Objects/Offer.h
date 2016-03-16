//
//  Offer.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Partner.h"
#import "OfferStatus.h"
#import "RewardTierHelper.h"

@interface Offer : NSObject

@property (nonatomic) NSInteger offerId;
@property (nonatomic) OfferStatus offerStatus;
@property (nonatomic, strong) Partner *partner;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *expirationDate;
@property (nonatomic, strong) NSNumber *rewardValue;
@property (nonatomic) NSInteger currentParticipants;
@property (nonatomic) NSInteger totalParticipants;
@property (nonatomic) RewardTier minRewardTier;

// Offer Details
@property (nonatomic, strong) NSArray *infoFilterList;
@property (nonatomic, strong) NSArray *infoRequiredList;
@property (nonatomic, strong) NSArray *filterCategoriesList;
@property (nonatomic, strong) NSArray *requiredCategoriesList;

@property (nonatomic, strong) NSString *offerDescription;

- (BOOL)isEligible;
- (BOOL)isExpired;
- (NSArray *)missingInformationList;
- (NSString *)rewardString;
- (CGFloat)participantsProgress;

// Message
@property (nonatomic) BOOL didReadMessage;
@property (nonatomic) NSInteger messageId;

@end
