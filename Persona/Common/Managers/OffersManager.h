//
//  OffersManager.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Offer.h"

@interface OffersManager : NSObject

typedef NS_ENUM(NSUInteger, OfferSortType) {
    OfferSortTypeRank,
    OfferSortTypePartner,
    OfferSortTypeReward,
    OfferSortTypeExpirationTime,
    OfferSortTypeCategory
};

+ (NSArray *)parseOffersFromJSONFile:(NSString *)fileLocation;
+ (NSArray *)sortOffers:(NSArray *)offers bySortType:(OfferSortType)sortType;

@end
