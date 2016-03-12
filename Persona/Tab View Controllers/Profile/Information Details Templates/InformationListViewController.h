//
//  InformationListViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationTemplateViewController.h"
#import "InformationManualEntryViewController.h"

@interface InformationListViewController : InformationTemplateViewController <UITableViewDelegate, InformationEntryDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
