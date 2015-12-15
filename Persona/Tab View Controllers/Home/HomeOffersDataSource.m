//
//  HomeOffersDataSource.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "HomeOffersDataSource.h"

@implementation HomeOffersDataSource

//- (id)initWithOffers:(NSArray *)offers
//{
//    self = [super initWithOffers:offers];
//    if (self) {
//        
//    }
//    return self;
//}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end
