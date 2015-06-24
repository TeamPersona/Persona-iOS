//
//  FeaturedViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "FeaturedViewController.h"
#import "FeaturedOffersDataSource.h"
#import "OfferTableViewCell.h"
#import "OffersManager.h"
#import "Constants.h"

@interface FeaturedViewController ()
@property (nonatomic, strong) FeaturedOffersDataSource *dataSource;
@end

@implementation FeaturedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OfferTableViewCell" bundle:nil] forCellReuseIdentifier:OfferTableViewCellIdentifier];
    
    NSArray *offers;
#if DEBUG
    offers = [OffersManager parseOffersFromJSONFile:@"featuredOffersTestData1.json"];
    self.dataSource = [[FeaturedOffersDataSource alloc] initWithOffers:offers];
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

@end
