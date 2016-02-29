//
//  InformationTextFieldViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationTextFieldViewController.h"
#import "UIColor+ProjectColors.h"
#import <QuartzCore/QuartzCore.h>

@interface InformationTextFieldViewController ()
@property (nonatomic, strong) InformationDetails *infoDetails;
@end

@implementation InformationTextFieldViewController

- (instancetype)initWithInfoDetails:(InformationDetails *)details
{
    self = [super init];
    if (self) {
        self.infoDetails = details;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.textField.borderStyle = UITextBorderStyleNone;
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

@end
