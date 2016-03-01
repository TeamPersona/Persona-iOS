//
//  InformationTemplateViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationTemplateViewController.h"
#import "InformationTextFieldViewController.h"
#import "InformationDateViewController.h"

@interface InformationTemplateViewController ()

@end

@implementation InformationTemplateViewController

- (instancetype)initWithInfoDetails:(InformationDetails *)infoDetails
{
    self = [super init];
    if (self) {
        self.infoDetails = infoDetails;
    }
    return self;
}

- (instancetype)initInfoTemplateViewController:(InformationDetails *)infoDetails
{
    if (infoDetails.type == InformationDetailsTypeString) {
        return [[InformationTextFieldViewController alloc] initWithInfoDetails:infoDetails];
    } else if (infoDetails.type == InformationDetailsTypeNumber) {
        return [[InformationTextFieldViewController alloc] initWithInfoDetails:infoDetails];
    } else if (infoDetails.type == InformationDetailsTypeBoolean) {
    } else if (infoDetails.type == InformationDetailsTypeDate) {
        return [[InformationDateViewController alloc] initWithInfoDetails:infoDetails];
    } else if (infoDetails.type == InformationDetailsTypeOptionSingle) {
        
    } else if (infoDetails.type == InformationDetailsTypeOptionMultiple) {
        
    }
    return [self initWithInfoDetails:infoDetails];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
