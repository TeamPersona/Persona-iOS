//
//  ProfileViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingsViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonPressed:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Methods
- (void)settingsButtonPressed:(UIBarButtonItem *)sender
{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}


@end
