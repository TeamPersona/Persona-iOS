//
//  WelcomeViewController.h
//  Persona
//
//  Created by Denny Kim on 2015-07-14.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface WelcomeViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginPanelBottomSpaceLayoutConstraint;

@property (weak, nonatomic) IBOutlet UIView *loginPanelView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginWithFacebook;

@property (weak, nonatomic) IBOutlet UILabel *errorSignUpLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
