//
//  InformationCategory.h
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformationDetails.h"

@interface InformationCategory : NSObject

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic) NSInteger completionPoints;
@property (nonatomic, strong) NSMutableArray<InformationDetails *> *informationDetails;
@property (nonatomic) NSInteger totalReceivedPoints;

@end
