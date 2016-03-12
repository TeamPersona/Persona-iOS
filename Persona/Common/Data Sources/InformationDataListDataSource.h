//
//  InformationDataListDataSource.h
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InformationDataListDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *dataPoints;
@property (nonatomic) BOOL canEdit;

@end
