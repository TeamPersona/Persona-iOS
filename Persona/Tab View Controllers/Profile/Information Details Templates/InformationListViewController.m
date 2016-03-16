//
//  InformationListViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationListViewController.h"
#import "BaseNavigationViewController.h"
#import "InformationDataTableViewCell.h"
#import "InformationDataListDataSource.h"
#import "ServerAPIManager.h"
#import "NSString+CamelCase.h"

@interface InformationListViewController ()

@property (nonatomic, strong) InformationDataListDataSource *dataSource;

@end

@implementation InformationListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataSource = [[InformationDataListDataSource alloc] init];
    self.dataSource.canEdit = NO;
    self.dataSource.dataPoints = [NSMutableDictionary dictionaryWithDictionary:self.infoDetails.value];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationDataTableViewCell" bundle:nil] forCellReuseIdentifier:InformationDataTableViewCellIdentifier];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 46.0f, 0);
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self.dataSource;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Methods
- (IBAction)addManualEntryButtonPressed:(UIButton *)sender
{
    InformationManualEntryViewController *vc = [[InformationManualEntryViewController alloc] initWithInformationSubCategory:self.infoDetails.name existingData:self.infoDetails.value];
    vc.delegate = self;
    [self presentViewController:[[BaseNavigationViewController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

#pragma mark - Information Manual Entry Delegate Methods
- (void)informationDidFinishEntryWithData:(NSDictionary *)dataDict
{
    self.infoDetails.value = dataDict;
    self.dataSource.dataPoints = [NSMutableDictionary dictionaryWithDictionary:dataDict];
    [self.tableView reloadData];
    
    PersonalInformation *info = [PersonalInformation new];
    info.category = self.infoDetails.mainCategory;
    info.subCategory = self.infoDetails.name;
    info.data = self.infoDetails.value;
    
    [[ServerAPIManager sharedManager] accountDeposit:info completion:^(BOOL success, id response, NSError *error) {
        if (success) {
            NSLog(@"%@", response);
        } else {
            NSLog(@"%@", error);
        }
    }];
}

@end
