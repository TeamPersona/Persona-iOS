//
//  InformationTemplateViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationDetails.h"

@interface InformationTemplateViewController : UIViewController

- (instancetype)initWithInfoDetails:(InformationDetails *)infoDetails;
- (instancetype)initInfoTemplateViewController:(InformationDetails *)infoDetails;

@property (nonatomic, strong) InformationDetails *infoDetails;

@end
