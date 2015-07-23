//
//  FeaturedViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "FeaturedViewController.h"
#import "FeaturedOffersDataSource.h"
#import "OfferDetailsViewController.h"
#import "OfferTableViewCell.h"
#import "OffersManager.h"
#import "Constants.h"

@interface FeaturedViewController ()
@property (nonatomic, strong) FeaturedOffersDataSource *dataSource;
@property (nonatomic, strong) NSArray *offers;
@end

@implementation FeaturedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OfferTableViewCell" bundle:nil] forCellReuseIdentifier:OfferTableViewCellIdentifier];
    
#if DEBUG
    self.offers = [OffersManager parseOffersFromJSONFile:@"featuredOffersTestData1.json"];
    self.dataSource = [[FeaturedOffersDataSource alloc] initWithOffers:self.offers];
    self.tableView.dataSource = self.dataSource;
#endif
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferDetailsViewController *offerDetailsVC = [[OfferDetailsViewController alloc] initWithOffer:self.offers[indexPath.row]];
    [self.navigationController pushViewController:offerDetailsVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
