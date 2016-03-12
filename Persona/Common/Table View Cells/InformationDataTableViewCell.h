//
//  InformationDataTableViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *InformationDataTableViewCellIdentifier = @"informationDataCellIdentifier";

@interface InformationDataTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *detailNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailDataLabel;

@end
