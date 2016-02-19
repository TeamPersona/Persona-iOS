//
//  RecommendedDataSource.h
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RecommendedDataSource : NSObject <UICollectionViewDataSource>

- (id)initWithRecommendedOffers:(NSArray *)recommendedOffers;

@end
