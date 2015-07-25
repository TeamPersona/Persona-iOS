//
//  OffersDataSource.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "OffersDataSource.h"
#import "OfferTableViewCell.h"
#import "Offer.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OffersDataSource ()
@property (nonatomic, strong) NSArray *offers;
@end

@implementation OffersDataSource

- (id)initWithOffers:(NSArray *)offers
{
    self = [super init];
    if (self) {
        self.offers = offers;
    }
    return self;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.offers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OfferTableViewCellIdentifier forIndexPath:indexPath];
    Offer *offer = self.offers[indexPath.row];
    
    cell.titleLabel.text = offer.partner.name;
    [cell.partnerImageView sd_setImageWithURL:offer.partner.partnerImageURL];
    cell.categoryLabel.text = [offer.categoryList componentsJoinedByString:@", "];
    cell.expirationTimeLabel.text = offer.expirationDate.description; // TODO: epoch time to time remaining
    cell.rewardLabel.text = offer.rewardString;
    cell.remainingLabel.text = [NSString stringWithFormat:@"%li remaining", (long)(offer.totalParticipants - offer.currentParticipants)];
    cell.progressView.progress = offer.participantsProgress;
    return cell;
}

@end
