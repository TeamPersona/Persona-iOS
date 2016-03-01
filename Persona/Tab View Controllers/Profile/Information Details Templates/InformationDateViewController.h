//
//  InformationDateViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationTemplateViewController.h"

@interface InformationDateViewController : InformationTemplateViewController

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
