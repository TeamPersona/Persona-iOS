//
//  InformationTextFieldViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationTextFieldViewController.h"
#import "UIColor+ProjectColors.h"

@implementation InformationTextFieldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.delegate = self;
    if (self.infoDetails.type == InformationDetailsTypeString) {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    } else if (self.infoDetails.type == InformationDetailsTypeNumber) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }

    self.infoLabel.text = [NSString stringWithFormat:@"Enter your %@:", self.infoDetails.name.lowercaseString];
    self.textField.text = (NSString *)self.infoDetails.value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.infoDetails.value = @{self.infoDetails.name : self.textField.text};
}

@end
