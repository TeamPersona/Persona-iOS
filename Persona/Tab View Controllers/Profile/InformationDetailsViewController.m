//
//  InformationDetailsViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationDetailsViewController.h"
#import "UIColor+ProjectColors.h"
#import "InformationTextFieldViewController.h"

@interface InformationDetailsViewController ()
@property (nonatomic, strong) UIViewController *informationTemplateViewController;
@property (nonatomic, strong) InformationDetails *infoDetails;
@end

@implementation InformationDetailsViewController

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
    
    self.titleLabel.text = self.infoDetails.name;
    
    [self updateButton:self.informationSegmentedButton state:YES];
    [self updateButton:self.permissionsSegmentedButton state:NO];

    if (self.infoDetails.type == InformationDetailsTypeString) {
        self.informationTemplateViewController = [[InformationTextFieldViewController alloc] initWithInfoDetails:self.infoDetails];
    } else if (self.infoDetails.type == InformationDetailsTypeNumber) {
        self.informationTemplateViewController = [[InformationTextFieldViewController alloc] initWithInfoDetails:self.infoDetails];
    } else if (self.infoDetails.type == InformationDetailsTypeBoolean) {
        
    } else if (self.infoDetails.type == InformationDetailsTypeDate) {
        
    } else if (self.infoDetails.type == InformationDetailsTypeDate) {
        
    } else if (self.infoDetails.type == InformationDetailsTypeOptionSingle) {
        
    } else if (self.infoDetails.type == InformationDetailsTypeOptionMultiple) {
        
    }
}

- (void)viewDidLayoutSubviews
{
    self.informationTemplateViewController.view.frame = self.infoView.bounds;
    [self.infoView addSubview:self.informationTemplateViewController.view];
    [self addChildViewController:self.informationTemplateViewController];
    [self.informationTemplateViewController didMoveToParentViewController:self];
    self.permissionTableView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Button Methods
- (IBAction)segmentedButtonPressed:(UIButton *)sender
{
    [self updateButton:sender state:YES];
    if ([sender isEqual:self.informationSegmentedButton]) {
        [self updateButton:self.permissionsSegmentedButton state:NO];
        self.infoView.hidden = NO;
        self.permissionTableView.hidden = YES;
    } else if ([sender isEqual:self.permissionsSegmentedButton]) {
        [self updateButton:self.informationSegmentedButton state:NO];
        self.permissionTableView.hidden = NO;
        self.infoView.hidden = YES;
    }
}

- (IBAction)doneButtonPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Window resizing
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark - UITableView Delegate Methods




#pragma mark - Private Methods
- (void)updateButton:(UIButton *)button state:(BOOL)shouldSelect
{
    if (shouldSelect) {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        button.backgroundColor = [UIColor personaColor];
    } else {
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        button.backgroundColor = [UIColor personaLightColor];
    }
}

@end
