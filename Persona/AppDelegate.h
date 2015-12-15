//
//  AppDelegate.h
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)transitionToMainTabView:(BOOL)animated;
- (void)logoutToWelcomeView:(BOOL)animated;

@end

