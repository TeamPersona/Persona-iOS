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
#import "AppDelegate.h"
#import "ServerAPIManager.h"

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
    [self.firstNameTextField becomeFirstResponder];
    
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    if (environment[@"EnvAccountShouldGenerate"]) {
        self.firstNameTextField.text = @"Denny";
        self.lastNameTextField.text = @"Kim";
        self.phoneNumberTextField.text = @"1231231234";
    }
    if (environment[@"EnvAccountPassword"]) {
        self.passwordTextField.text = environment[@"EnvAccountPassword"];
        self.confirmPasswordTextField.text = environment[@"EnvAccountPassword"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Methods
- (IBAction)doneButtonPressed:(UIButton *)sender
{
    PersonaAccountParameters *params = [PersonaAccountParameters new];
    params.firstName = self.firstNameTextField.text;
    params.lastName = self.lastNameTextField.text;
    params.email = self.emailString;
    params.phoneNumber = self.phoneNumberTextField.text;
    params.password = self.passwordTextField.text;
    
    [[ServerAPIManager sharedManager] accountCreatePersonaAccount:params completionBlock:^(BOOL success, NSDictionary *response, NSError *error) {
        if (success) {
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate transitionToMainTabView:YES];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - UITextField Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.firstNameTextField]) {
        [self.lastNameTextField becomeFirstResponder];
    } else if ([textField isEqual:self.lastNameTextField]) {
        [self.passwordTextField becomeFirstResponder];
    } else if ([textField isEqual:self.passwordTextField]) {
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
            self.doneButton.hidden = NO;
        }
    } else {
        if (!self.doneButton.hidden) {
            self.doneButton.hidden = YES;
        }
    }
}

- (void)showPasswordDoesNotMatchError:(BOOL)shouldShow
{
    if (shouldShow) {
        self.doesPasswordMatch = NO;
        self.errorLabel.hidden = NO;
        self.doneButton.hidden = YES;
    } else {
        self.doesPasswordMatch = YES;
        self.errorLabel.hidden = YES;
        if ([self.phoneNumberTextField.text isValidPhoneNumber]) {
            self.doneButton.hidden = NO;
        }
    }
}

@end
