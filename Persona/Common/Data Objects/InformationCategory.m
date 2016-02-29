//
//  InformationCategory.m
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationCategory.h"

@implementation InformationCategory

- (NSInteger)totalReceivedPoints
{
    NSInteger total = 0;
    for (InformationDetails *details in self.informationDetails) {
        if (details.value) {
            total += details.points;
        }
    }
    return total;
}

@end
