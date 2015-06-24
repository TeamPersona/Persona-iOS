//
//  OffersDataSource.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OffersDataSource : NSObject <UITableViewDataSource>

- (id)initWithOffers:(NSArray *)offers;

@end
