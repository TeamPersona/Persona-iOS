//
//  InformationTextFieldViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationTemplateViewController.h"

@interface InformationTextFieldViewController : InformationTemplateViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
