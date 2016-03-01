//
//  InformationDetailsViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationDetails.h"

@protocol InformationDetailsPopupDelegate <NSObject>

- (void)updateInformationDetails:(InformationDetails *)details atIndex:(NSInteger)index;

@end

@interface InformationDetailsViewController : UIViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *informationSegmentedButton;
@property (weak, nonatomic) IBOutlet UIButton *permissionsSegmentedButton;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UITableView *permissionTableView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (nonatomic, strong) id<InformationDetailsPopupDelegate> delegate;
@property (nonatomic) NSInteger index;

- (instancetype)initWithInfoDetails:(InformationDetails *)details;

@end
