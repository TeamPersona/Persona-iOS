//
//  AppDelegate.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "MainTabBarController.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize userDefaults if necessary
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults objectForKey:IS_LOGGED_IN]) {
        [userDefaults setObject:@NO forKey:IS_LOGGED_IN];
    }
    
    UIViewController *viewControllerToPresent;
    if ([userDefaults boolForKey:IS_LOGGED_IN]) {
        viewControllerToPresent = [[MainTabBarController alloc] initWithDefaultTabBarViewControllers];
    } else {
        viewControllerToPresent = [[UINavigationController alloc] initWithRootViewController:[[WelcomeViewController alloc] init]];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = viewControllerToPresent;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Transition To Main
- (void)transitionToMainTabView:(BOOL)animated
{
    [UIView transitionWithView:self.window
                      duration:0.6
                       options:(UIViewAnimationOptionTransitionFlipFromLeft |
                                UIViewAnimationOptionAllowAnimatedContent)
                    animations:^{
                        self.window.rootViewController = [[MainTabBarController alloc] initWithDefaultTabBarViewControllers];
                    } completion:nil];
}

@end
