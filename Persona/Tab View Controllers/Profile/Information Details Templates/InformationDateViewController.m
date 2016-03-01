//
//  InformationDateViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationDateViewController.h"
#import "NSDate+EpochTime.h"

@implementation InformationDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.datePicker.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    if (self.infoDetails.value) {
        self.datePicker.date = [NSDate dateWithEpochTime:self.infoDetails.value];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)datePckerDidUpdate:(UIDatePicker *)sender
{
    self.infoDetails.value = sender.date.epochTime;
}

@end
