//
//  MainTabBarController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "MainTabBarController.h"

#import "BaseNavigationViewController.h"
#import "HomeViewController.h"
#import "ExploreViewController.h"
#import "MessagesViewController.h"
#import "ProfileViewController.h"

static NSString *TabBarHomeTitle =      @"Home";
static NSString *TabBarMessagesTitle =  @"Messages";
static NSString *TabBarProfileTitle =   @"Profile";


@interface MainTabBarController ()
@property (nonatomic, strong) BaseNavigationViewController *homeNavVC;
@property (nonatomic, strong) BaseNavigationViewController *messagesNavVC;
@property (nonatomic, strong) BaseNavigationViewController *profileNavVC;

@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) MessagesViewController *messagesVC;
@property (nonatomic, strong) ProfileViewController *profileVC;
@end

@implementation MainTabBarController

- (id)initWithDefaultTabBarViewControllers
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageButtonPressed:) name:@"NotificationOpenMessage" object:nil];
        
        self.homeVC = [[HomeViewController alloc] initWithTabBarTitle:TabBarHomeTitle];
        self.messagesVC = [[MessagesViewController alloc] initWithTabBarTitle:TabBarMessagesTitle];
        self.profileVC = [[ProfileViewController alloc] initWithTabBarTitle:TabBarProfileTitle];

        self.homeNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.homeVC];
        self.messagesNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.messagesVC];
        self.profileNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.profileVC];
        
        [self setViewControllers:@[self.homeNavVC, self.messagesNavVC, self.profileNavVC]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)messageButtonPressed:(NSNotification *)notification
{
    self.selectedIndex = 1;
    [self.messagesVC openMessageWithOfferId:[notification.userInfo[@"offerId"] integerValue]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
