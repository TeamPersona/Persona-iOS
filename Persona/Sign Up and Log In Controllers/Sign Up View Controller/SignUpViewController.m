//
//  SignUpViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-07-15.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "SignUpViewController.h"
#import "PhoneVerificationViewController.h"
#import "NSString+PhoneNumber.h"

static NSString *SignUpTitle = @"Sign Up";

@interface SignUpViewController ()
@property (nonatomic, strong) NSString *emailString;
@property (nonatomic) BOOL doesPasswordMatch;
@end

@implementation SignUpViewController

- (id)initWithEmail:(NSString *)emailString
{
    self = [super init];
    if (self) {
        self.title = SignUpTitle;
        self.emailString = emailString;
        self.doesPasswordMatch = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.emailLabel.text = self.emailString;
    [self.passwordTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Methods
- (IBAction)sendCodeButton:(UIButton *)sender
{
    // send verification code
    
    // transition to verification view
    [self.navigationController pushViewController:[[PhoneVerificationViewController alloc] init] animated:YES];
}

#pragma mark - UITextField Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.passwordTextField]) {
        [self.confirmPasswordTextField becomeFirstResponder];
    } else if ([textField isEqual:self.confirmPasswordTextField]) {
        [self.phoneNumberTextField becomeFirstResponder];
    }
    return YES;
}

- (IBAction)confirmPasswordTextFieldEditingDidEnd:(UITextField *)sender
{
    if (sender.text.length != 0 && [sender.text isEqualToString:self.passwordTextField.text]) {
        [self showPasswordDoesNotMatchError:NO];
    } else {
        [self showPasswordDoesNotMatchError:YES];
    }
}

- (IBAction)confirmPasswordTextFieldEditingChanged:(UITextField *)sender
{
    // Don't do real-time updates unless the phone number textfield is filled in
    if (self.phoneNumberTextField.text.length != 0 && sender.text.length != 0) {
        if ([sender.text isEqualToString:self.passwordTextField.text]) {
            [self showPasswordDoesNotMatchError:NO];
        } else {
            [self showPasswordDoesNotMatchError:YES];
        }
    }
}

- (IBAction)phoneTextFieldEditingChanged:(UITextField *)sender
{
    //TODO: format text to phone number (###)-###-####
    if (sender.text.length == 10) {
        if (self.doesPasswordMatch) {
            self.sendCodeButton.hidden = NO;
        }
    } else {
        if (!self.sendCodeButton.hidden) {
            self.sendCodeButton.hidden = YES;
        }
    }
}

- (void)showPasswordDoesNotMatchError:(BOOL)shouldShow
{
    if (shouldShow) {
        self.doesPasswordMatch = NO;
        self.errorLabel.hidden = NO;
        self.sendCodeButton.hidden = YES;
    } else {
        self.doesPasswordMatch = YES;
        self.errorLabel.hidden = YES;
        if ([self.phoneNumberTextField.text isValidPhoneNumber]) {
            self.sendCodeButton.hidden = NO;
        }
    }
}

@end
