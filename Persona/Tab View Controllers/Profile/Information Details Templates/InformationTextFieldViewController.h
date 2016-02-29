//
//  InformationTextFieldViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationDetails.h"

@interface InformationTextFieldViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) id<UITextFieldDelegate> textFieldDelegate;

- (instancetype)initWithInfoDetails:(InformationDetails *)details;

@end
