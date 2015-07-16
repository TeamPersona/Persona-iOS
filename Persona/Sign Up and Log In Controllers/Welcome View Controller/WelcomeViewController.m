//
//  WelcomeViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-07-14.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "WelcomeViewController.h"
#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "NSString+EmailValidation.h"

typedef NS_ENUM(NSInteger, WelcomeState) {
    WelcomeStateSignUp,
    WelcomeStateLogin
};

@interface WelcomeViewController ()
@property (nonatomic) WelcomeState currentWelcomeState;
@end


@implementation WelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
 
    self.currentWelcomeState = self.segmentedControl.selectedSegmentIndex;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISegmentedControl Methods
- (IBAction)segmentedControlValueDidChange:(UISegmentedControl *)sender
{
    self.currentWelcomeState = sender.selectedSegmentIndex;
    [self hideKeyboard];
    
    self.emailTextField.text = @"";
    self.passwordTextField.text = @"";
    self.nextButton.hidden = YES;
    self.errorSignUpLabel.hidden = YES;
    self.loginButton.hidden = YES;
    
    if (sender.selectedSegmentIndex == 0) { // Sign Up
        self.passwordTextField.hidden = YES;
        self.forgotPasswordButton.hidden = YES;
    } else if (sender.selectedSegmentIndex == 1) { // Log In
        self.passwordTextField.hidden = NO;
        self.forgotPasswordButton.hidden = NO;
    }
}

#pragma mark - UITextField Methods
- (IBAction)emailTextFieldEditingChanged:(UITextField *)textField
{
    if (self.currentWelcomeState == WelcomeStateSignUp) {
        if (textField.text.length != 0 && [textField.text isValidEmail]) {
            //TODO: find out if this email is taken
            BOOL isTaken = NO;
            if (isTaken) {
                self.errorSignUpLabel.hidden = YES;
            } else {
                self.nextButton.hidden = NO;
            }
        } else {
            self.nextButton.hidden = YES;
            self.errorSignUpLabel.hidden = YES;
        }
    } else {
        if (![textField.text isValidEmail]) {
            [self allowPasswordTextFieldToLogin:NO];
        } else if ([textField.text isValidEmail] && self.passwordTextField.text.length != 0) {
            [self allowPasswordTextFieldToLogin:YES];
        }
    }
}

- (IBAction)passwordTextFieldEditingChanged:(UITextField *)textField
{
    if (textField.text.length == 0) {
        [self allowPasswordTextFieldToLogin:NO];
    } else if (textField.text.length != 0 && [self.emailTextField.text isValidEmail]) {
        [self allowPasswordTextFieldToLogin:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.emailTextField]) {
        if (self.currentWelcomeState == WelcomeStateSignUp) {
            [self nextButtonPressed:nil];
        } else {
            [self.passwordTextField becomeFirstResponder];
        }
    } else if ([textField isEqual:self.passwordTextField]) {
        [self loginButtonPressed:nil];
    }
    
    return YES;
}

- (void)allowPasswordTextFieldToLogin:(BOOL)allowLogin
{
    if (allowLogin) {
        self.loginButton.hidden = NO;
        self.forgotPasswordButton.hidden = YES;
        [self.passwordTextField setEdgeInsets:UIEdgeInsetsMake(0, 0, 0, self.loginButton.bounds.size.width)];
    } else {
        self.loginButton.hidden = YES;
        self.forgotPasswordButton.hidden = NO;
        [self.passwordTextField setEdgeInsets:UIEdgeInsetsMake(0, 0, 0, self.forgotPasswordButton.bounds.size.width)];
    }
}

#pragma mark - Button Methods
- (IBAction)nextButtonPressed:(UIButton *)sender
{
    [self hideKeyboard];
    
    SignUpViewController *vc = [[SignUpViewController alloc] initWithEmail:self.emailTextField.text];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    // Basic client-side validation
    if ([email isValidEmail] && password.length != 0) {
        //TODO: call API for login
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate transitionToMainTabView:YES];
    }
}


#pragma mark - Keyboard
- (void)hideKeyboard
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    
    // Frames and sizes
    CGRect keyboardRect = [[keyboardInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.loginPanelBottomSpaceLayoutConstraint.constant = keyboardRect.size.height;
    
    // Animation options
    double animationDuration = [[keyboardInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[keyboardInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView setAnimationCurve:animationCurve];
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];

    // Frames and sizes
    self.loginPanelBottomSpaceLayoutConstraint.constant = 0;

    // Animation options
    double animationDuration = [[keyboardInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[keyboardInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [UIView animateWithDuration:animationDuration animations:^{
        [UIView setAnimationCurve:animationCurve];
        [self.view layoutIfNeeded];
    }];
}

@end
