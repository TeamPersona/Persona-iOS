//
//  InformationDetailsDataSource.h
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "InformationCategory.h"

@interface InformationDetailsDataSource : NSObject <UICollectionViewDataSource>

- (id)initWithInfoCategory:(InformationCategory *)info;
- (void)updateInfo:(InformationCategory *)info;

@end
