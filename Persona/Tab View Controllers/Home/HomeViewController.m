//
//  FeaturedViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "HomeViewController.h"
#import "CompletedTransactionsDataSource.h"
#import "PendingTransactionsDataSource.h"
#import "RecommendedDataSource.h"
#import "OfferDetailsViewController.h"
#import "OfferTableViewCell.h"
#import "OffersManager.h"
#import "Constants.h"

@interface HomeViewController ()
@property (nonatomic, strong) NSArray *offers;
@property (nonatomic, strong) NSArray *recommendedOffers;
@property (nonatomic, strong) NSArray *homeTableViewTitles;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SideScrollingCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:SideScrollingCollectionTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"OfferTableViewCell" bundle:nil] forCellReuseIdentifier:OfferTableViewCellIdentifier];
    
    self.tableView.dataSource = self;
    
    self.homeTableViewTitles = @[@"Completed Transactions", @"Pending Transactions", @"Recommended For You"];
    
    
#if DEBUG
    self.offers = [OffersManager parseRecommendedOffersFromJSONFile:@"offers.json"];
    self.recommendedOffers = [OffersManager parseRecommendedOffersFromJSONFile:@"offers.json"];
#endif
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Side Scrolling Collection Delegate Methods
- (void)sideScrollingCollectionDidSelectCellIndexPath:(NSIndexPath *)indexPath
{
//    OfferDetailsViewController *vc = [OfferDetailsViewController alloc] initWithOffer:<#(Offer *)#>
}

#pragma mark -- UITableView DataSource Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2) {
        SideScrollingCollectionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SideScrollingCollectionTableViewCellIdentifier forIndexPath:indexPath];
        cell.sectionNumber = indexPath.section;
        cell.collectionArray = self.offers[indexPath.row];
        
        if (indexPath.section == 0) {
        cell.dataSource = [[CompletedTransactionsDataSource alloc] initWithCompletedTransactions:nil];
        } else if (indexPath.section == 1) {
            cell.dataSource = [[PendingTransactionsDataSource alloc] initWithPendingTransactions:nil];
        }
        return cell;
    } else {
        OfferTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:OfferTableViewCellIdentifier forIndexPath:indexPath];
        [cell populateOfferInfo:self.recommendedOffers[indexPath.row]];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.homeTableViewTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < 2) {
        return 1;
    } else {
        return self.recommendedOffers.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.homeTableViewTitles[section];
}

#pragma mark -- UITableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2) {
        return 120.0f;
    } else {
        return OfferTableViewCellHeight;
    }
//
//    Offer *offer = self.offers[indexPath.row];
//    if (!offer.isExpired) {
//        return OfferTableViewCellHeight;
//    } else {
//        return OfferTableViewCellHeightExpired;
//    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2) {
        return nil;
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        OfferDetailsViewController *offerDetailsVC = [[OfferDetailsViewController alloc] initWithOffer:self.offers[indexPath.row]];
        [self.navigationController pushViewController:offerDetailsVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2) {
        return NO;
    } else {
        return YES;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
