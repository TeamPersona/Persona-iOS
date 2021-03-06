//
//  MainTabBarController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "MainTabBarController.h"

#import "BaseNavigationViewController.h"
#import "FeaturedViewController.h"
#import "ExploreViewController.h"
#import "MessagesViewController.h"
#import "ProfileViewController.h"

static NSString *TabBarFeaturedTitle =  @"Featured";
static NSString *TabBarExploreTitle =   @"Explore";
static NSString *TabBarMessagesTitle =  @"Messages";
static NSString *TabBarProfileTitle =   @"Profile";


@interface MainTabBarController ()
@property (nonatomic, strong) BaseNavigationViewController *featuredNavVC;
@property (nonatomic, strong) BaseNavigationViewController *exploreNavVC;
@property (nonatomic, strong) BaseNavigationViewController *messagesNavVC;
@property (nonatomic, strong) BaseNavigationViewController *profileNavVC;

@property (nonatomic, strong) FeaturedViewController *featuredVC;
@property (nonatomic, strong) ExploreViewController *exploreVC;
@property (nonatomic, strong) MessagesViewController *messagesVC;
@property (nonatomic, strong) ProfileViewController *profileVC;
@end

@implementation MainTabBarController

- (id)initWithDefaultTabBarViewControllers
{
    self = [super init];
    if (self) {
        self.featuredVC = [[FeaturedViewController alloc] initWithTabBarTitle:TabBarFeaturedTitle];
        self.exploreVC = [[ExploreViewController alloc] initWithTabBarTitle:TabBarExploreTitle];
        self.messagesVC = [[MessagesViewController alloc] initWithTabBarTitle:TabBarMessagesTitle];
        self.profileVC = [[ProfileViewController alloc] initWithTabBarTitle:TabBarProfileTitle];

        self.featuredNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.featuredVC];
        self.exploreNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.exploreVC];
        self.messagesNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.messagesVC];
        self.profileNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.profileVC];
        
        [self setViewControllers:@[self.featuredNavVC, self.exploreNavVC, self.messagesNavVC, self.profileNavVC]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
