//
//  InformationDetailsViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationDetails.h"

@interface InformationDetailsViewController : UIViewController <UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *informationSegmentedButton;
@property (weak, nonatomic) IBOutlet UIButton *permissionsSegmentedButton;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UITableView *permissionTableView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (instancetype)initWithInfoDetails:(InformationDetails *)details;

@end
