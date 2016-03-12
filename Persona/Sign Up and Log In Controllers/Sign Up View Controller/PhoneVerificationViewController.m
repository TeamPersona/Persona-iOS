//
//  PhoneVerificationViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-07-15.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "PhoneVerificationViewController.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"
#import "Constants.h"

static NSString *VerificationTitle = @"Verification";

@interface PhoneVerificationViewController ()
@property (nonatomic, strong) NSString *phoneNumString;
@end

@implementation PhoneVerificationViewController

- (id)initWithPhoneNumber:(NSString *)phoneNumString
{
    self = [super init];
    if (self) {
        self.title = VerificationTitle;
        self.phoneNumString = phoneNumString;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self clearValidationCode];
    [self.textField1 becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API Methods
- (BOOL)validateVerificationNumber:(NSString *)numString
{
    //TODO: call API to validate this verification number with the linked phone number
    return YES;
}

#pragma mark - UITextField Methods
- (IBAction)textFieldEditingChanged:(UITextField *)textField
{
    if (textField.text.length != 0) {
        if ([textField isEqual:self.textField1]) {
            [self.textField2 becomeFirstResponder];
        } else if ([textField isEqual:self.textField2]) {
            [self.textField3 becomeFirstResponder];
        } else if ([textField isEqual:self.textField3]) {
            [self.textField4 becomeFirstResponder];
        } else if ([textField isEqual:self.textField4]) {
            [self.textField5 becomeFirstResponder];
        } else if ([textField isEqual:self.textField5]) {
            NSString *numString = [self.textField1.text stringByAppendingFormat:@"%@%@%@%@",
                                   self.textField2.text,
                                   self.textField3.text,
                                   self.textField4.text,
                                   self.textField5.text];
            
            if ([self validateVerificationNumber:numString]) {
                AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                [appDelegate transitionToMainTabView:YES];
                // TODO: call server login 
            } else {
                [self clearValidationCode];
                [self.textField1 becomeFirstResponder];
                
                [UIView animateWithDuration:0.3
                                 animations:^{
                                     self.errorLabel.alpha = 1.0;
                                 } completion:^(BOOL finished) {
                                     [UIView animateWithDuration:0.3
                                                           delay:2.0
                                                         options:UIViewAnimationOptionCurveEaseInOut
                                                      animations:^{
                                                          self.errorLabel.alpha = 0.0;
                                                      } completion:nil];
                                 }];
            }
        }
    }
}

- (void)clearValidationCode
{
    self.textField1.text = @"";
    self.textField2.text = @"";
    self.textField3.text = @"";
    self.textField4.text = @"";
    self.textField5.text = @"";
}
    
#pragma mark - Button Methods
- (IBAction)resendCodeButtonPressed:(UIButton *)sender
{
}

@end
